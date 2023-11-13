local home = vim.env.HOME
local config = home .. '/.config/nvim'

require('jaapied.plugins.plug')

require('wincent.commandt').setup()

require('mason').setup()
require('mason-lspconfig').setup()
