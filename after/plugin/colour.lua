local pinnacle = require('wincent.pinnacle')

vim.cmd('colorscheme base16-monokai')

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
-- local dark = vim.o.background == 'dark'
-- local factor = dark and 0.15 or -0.15
local normal = pinnacle.adjust_lightness('NormalFloat', -0.075)

pinnacle.set('NormalFloat', normal)
pinnacle.set('FloatBorder', { fg = pinnacle.fg('LineNr'), bg = pinnacle.bg('NormalFloat') })

pinnacle.merge('Comment', { italic = true })

vim.cmd('doautocmd ColorScheme')
