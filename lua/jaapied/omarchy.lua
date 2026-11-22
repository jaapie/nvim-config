-- Follow Omarchy's current theme when running on Omarchy.
--
-- Omarchy writes a lazy.nvim spec for the active theme to
-- ~/.local/state/omarchy/current/theme/neovim.lua. It is written for LazyVim:
-- the theme plugin, plus a "LazyVim/LazyVim" entry whose opts.colorscheme
-- names the colorscheme. This module takes the plugin specs, drops the
-- LazyVim entry, applies the colorscheme itself, and reapplies it when the
-- theme changes while Neovim is open.
--
-- Theme plugins load from the copies the omarchy-nvim package ships (kept
-- current by pacman), so nothing is downloaded. A theme whose plugin isn't
-- shipped falls back to catppuccin.

local M = {}

local state_dir = vim.fn.expand("~/.local/state/omarchy/current")
local theme_file = state_dir .. "/theme/neovim.lua"
local plugin_cache = "/etc/skel/.local/share/nvim/lazy"
local omarchy_path = vim.env.OMARCHY_PATH or "/usr/share/omarchy"

-- Theme plugins this config installs itself. These keep their normal spec so
-- lazy doesn't see one plugin coming from two places.
local own = { catppuccin = true }

-- Spec keys that only matter for fetching a plugin, dropped for local copies.
local fetch_keys = { url = true, branch = true, tag = true, commit = true, version = true, build = true }

local function name_of(spec)
  return spec.name or spec[1]:match("[^/]+$")
end

-- Point a theme plugin spec at the packaged copy. Returns nil if the package
-- doesn't ship that plugin.
local function localize(spec)
  local name = name_of(spec)
  if own[name] then
    return spec
  end
  -- The package names a plugin's folder after its spec name or, without one,
  -- its repo (monokai-pro is in "monokai-pro.nvim", aether in "aether").
  local dir
  for _, candidate in ipairs({ name, spec[1]:match("[^/]+$") }) do
    if vim.fn.isdirectory(plugin_cache .. "/" .. candidate) == 1 then
      dir = plugin_cache .. "/" .. candidate
      break
    end
  end
  if not dir then
    return nil
  end
  local out = { dir = dir, name = name }
  for k, v in pairs(spec) do
    if type(k) == "string" and not fetch_keys[k] and out[k] == nil then
      out[k] = v
    end
  end
  return out
end

-- Read a theme's neovim.lua. Returns its (localized) plugin specs, the
-- colorscheme name, and the repo of any plugin that isn't available locally.
local function read(file)
  local ok, spec = pcall(dofile, file)
  if not ok or type(spec) ~= "table" then
    return {}, nil, nil
  end
  local plugins, colorscheme, missing = {}, nil, nil
  for _, s in ipairs(spec) do
    if type(s) == "table" and type(s[1]) == "string" then
      if s[1] == "LazyVim/LazyVim" then
        colorscheme = s.opts and s.opts.colorscheme
      else
        local l = localize(s)
        if l then
          table.insert(plugins, l)
        else
          missing = s[1]
        end
      end
    end
  end
  return plugins, colorscheme, missing
end

-- "light" or "dark", from the theme's colors.toml (some colorschemes, such as
-- aether, don't set 'background' themselves).
local function mode()
  local ok, lines = pcall(vim.fn.readfile, state_dir .. "/theme/colors.toml")
  for _, line in ipairs(ok and lines or {}) do
    local m = line:match('^%s*mode%s*=%s*"(%a+)"')
    if m then
      return m
    end
  end
  return "dark"
end

local function apply(colorscheme)
  vim.cmd("highlight clear")
  vim.o.background = mode()
  local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify("Omarchy theme: " .. err, vim.log.levels.WARN)
  end
end

-- True on Omarchy when the current theme's plugin is available locally.
function M.active()
  if vim.uv.fs_stat(theme_file) == nil then
    return false
  end
  local _, colorscheme, missing = read(theme_file)
  return colorscheme ~= nil and missing == nil
end

-- The theme changed while Neovim is running.
local function reload()
  local plugins, colorscheme, missing = read(theme_file)
  if missing or not colorscheme then
    vim.notify("Omarchy theme plugin " .. (missing or "?") .. " isn't installed; using catppuccin", vim.log.levels.INFO)
    apply("catppuccin")
    return
  end
  local registry = require("lazy.core.config").plugins
  for _, spec in ipairs(plugins) do
    local plugin = registry[name_of(spec)]
    if not plugin then
      vim.notify("Omarchy theme plugin " .. name_of(spec) .. " isn't registered; restart Neovim", vim.log.levels.WARN)
      return
    end
    if spec.opts then
      plugin.opts = spec.opts
      plugin._.cache = nil -- drop lazy's resolved opts so the new ones are used
    end
    if plugin._.loaded then
      require("lazy.core.loader").reload(plugin) -- reruns setup() with the new opts
    else
      require("lazy.core.loader").load(plugin, { colorscheme = colorscheme })
    end
  end
  apply(colorscheme)
end

local watching = false
local function watch()
  if watching then
    return
  end
  local handle, timer = vim.uv.new_fs_event(), vim.uv.new_timer()
  if not handle or not timer then
    return
  end
  watching = true
  -- omarchy-theme-set swaps the whole theme dir, so watch its parent and
  -- debounce the burst of events a switch produces.
  handle:start(state_dir, {}, function(_, filename)
    if filename == "theme.name" or filename == "theme" then
      timer:stop()
      timer:start(300, 0, vim.schedule_wrap(reload))
    end
  end)
end

-- lazy.nvim specs: the current theme's plugin (loaded at startup, applies the
-- colorscheme) plus every other Omarchy theme's plugin (registered, not
-- loaded) so switching themes needs no restart. Empty when not on Omarchy.
function M.specs()
  if vim.uv.fs_stat(theme_file) == nil then
    return {}
  end

  local result, seen = {}, {}

  local plugins, colorscheme, missing = read(theme_file)
  if colorscheme and not missing then
    for i, spec in ipairs(plugins) do
      spec.lazy = false
      spec.priority = 1000
      if i == 1 then
        spec.config = function(plugin, opts)
          local main = require("lazy.core.loader").get_main(plugin)
          if main and opts and next(opts) then
            require(main).setup(opts)
          end
          apply(colorscheme)
        end
      end
      seen[spec.name or name_of(spec)] = true
      table.insert(result, spec)
    end
  end

  -- Themes without their own neovim.lua get one from Omarchy's template.
  local files = {}
  for _, pattern in ipairs({
    vim.fn.expand("~/.config/omarchy/themed/neovim.lua.tpl"),
    omarchy_path .. "/default/themed/neovim.lua.tpl",
    omarchy_path .. "/themes/*/neovim.lua",
    vim.fn.expand("~/.config/omarchy/themes/*/neovim.lua"),
  }) do
    vim.list_extend(files, vim.fn.glob(pattern, false, true))
  end
  for _, file in ipairs(files) do
    for _, spec in ipairs((read(file))) do
      local name = spec.name or name_of(spec)
      if not seen[name] then
        seen[name] = true
        if spec.dir then
          table.insert(result, { dir = spec.dir, name = name, lazy = true })
        else
          table.insert(result, { spec[1], name = name, lazy = true })
        end
      end
    end
  end

  vim.schedule(watch)
  return result
end

return M
