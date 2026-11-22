local pinnacle = require('wincent.pinnacle')

-- vim.cmd('colorscheme base16-monokai')

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- local dark = vim.o.background == 'dark'
-- local factor = dark and 0.15 or -0.15

-- Reapplied on every colorscheme change, so the tweaks survive Omarchy
-- switching themes while Neovim is open.
-- ColorScheme can fire several times for one theme, so skip when NormalFloat
-- still has the colour we set; otherwise the darkening compounds.
local tweaked_bg
local function tweak()
  if tweaked_bg and vim.api.nvim_get_hl(0, { name = 'NormalFloat', link = false }).bg == tweaked_bg then
    return
  end
  local normal = pinnacle.adjust_lightness('NormalFloat', -0.075)

  pinnacle.set('NormalFloat', normal)
  pinnacle.set('FloatBorder', { fg = pinnacle.fg('LineNr'), bg = pinnacle.bg('NormalFloat') })

  pinnacle.merge('Comment', { italic = true })
  tweaked_bg = vim.api.nvim_get_hl(0, { name = 'NormalFloat', link = false }).bg
end

-- The doautocmd applies it for the colorscheme already loaded at startup.
vim.api.nvim_create_autocmd('ColorScheme', { callback = tweak })
vim.cmd('doautocmd ColorScheme')
