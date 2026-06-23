# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal Neovim configuration for Jacob Degeling. Written in Lua, structured under the `jaapied` namespace.

## Architecture

`init.lua` loads two top-level modules in order:

1. **`lua/jaapied/core/`** — editor fundamentals, loaded eagerly before plugins:
   - `settings.lua` — `vim.opt` options
   - `commands.lua` — `filetype plugin indent on`, `syntax on`, `matchit`
   - `keymaps.lua` — global keymaps (leader = `<Space>`)
   - `autocommands.lua` — helper that wraps `nvim_create_autocmd`

2. **`lua/jaapied/plugins/`** — plugin management via [lazy.nvim](https://github.com/folke/lazy.nvim):
   - `init.lua` — bootstraps lazy.nvim and imports all files under `plugins/config/` as plugin specs
   - `config/*.lua` — each file returns a lazy.nvim plugin spec (or a list of specs)

**`after/plugin/`** — runs after all plugins load, used for highlight overrides and autocmds that depend on plugin state:
- `colour.lua` — float/border highlight tweaks using wincent/pinnacle
- `lsp_highlights.lua` — diagnostic underline styles (undercurl)
- `autocmds.lua` — filetype-specific autocmds (indentation, omnifunc, commentstring)

## Key plugins and their config files

| File | Plugin(s) |
|---|---|
| `lsp.lua` | nvim-lspconfig — ruby_lsp, stimulus_ls, sorbet (conditional on `sorbet/config`), html |
| `completion.lua` | nvim-cmp + cmp sources |
| `mason.lua` | mason + mason-lspconfig (auto_install = true) |
| `none.lua` | none-ls — stylua formatter, erb_lint diagnostics |
| `telescope.lua` | telescope (ivy theme for find_files, buffers, live_grep) |
| `oil.lua` | oil.nvim — default file explorer replacing netrw (`-` opens parent dir from any buffer) |
| `ruby.lua` | vim-ruby, vim-rails, vim-rspec, vim-endwise, vim-projectionist |
| `editing.lua` | vim-surround, vim-commentary, vim-repeat, vim-unimpaired, splitjoin, doorboy, vim-abolish, vim-speeddating |
| `text-objects.lua` | vim-textobj-css, vim-textobj-rubyblock |
| `catppuccin.lua` | Active colorscheme (mocha flavour) |

## LSP setup details

LSP keymaps are registered inside an `LspAttach` autocmd in `lsp.lua` (not globally). Sorbet is only enabled when `sorbet/config` exists in the project root — the root is detected via `vim.fs.root` and passed as `root_dir` in the config. Diagnostics use `virtual_lines = { current_line = true }` (no virtual_text).

LSP formatting is via `<leader>gf` → `vim.lsp.buf.format` (wired in `none.lua`).

## RSpec integration

vim-rspec keymaps (all in `keymaps.lua`):
- `<leader>t` — run current spec file
- `<leader>s` — run nearest spec
- `<leader>l` — run last spec
- `<leader>a` — run all specs

`rspec_command` is set to `!bundle exec rspec {spec}`.

`<leader>n` → `:A` (vim-projectionist alternate file).

## doorboy.vim note

doorboy intercepts bare `(`, `{`, `[` in insert mode and inserts the closing pair immediately. Only the `{<cr>` expansion keymap is defined in `keymaps.lua` — the `(<cr>` and `[<cr>` equivalents are omitted because doorboy blocks them.

## Commit conventions

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification). Format: `type(scope): short summary` — 50 char limit on the summary line.

Common types: `feat`, `fix`, `chore`, `refactor`, `docs`, `style`, `perf`.

Commit often at strategic points: after each logical change is working, before starting a related-but-distinct change, and before any risky refactor.
