local createautocommands = require('jaapied.core.autocommands')

vim.g.ale_set_highlights = 1
vim.g.ale_set_signs = 1
vim.g.ale_sign_error = ">>"
vim.g.ale_sign_warning = "--"
-- vim.g.ale_linters = { ruby = {'rubocop'} }

local autocommnads = {
  {
    event = 'ColorScheme', pattern = '*',
    callback = function()
      -- highlight ALEWarning term=undercurl cterm=undercurl ctermbg=NONE ctermfg=NONE guibg=NONE gui=undercurl guisp=#66d9ef
      vim.api.nvim_set_hl(0, 'ALEWarning', { undercurl = true, sp = "#66d9ef", bg = "none"})
    end
  }, {
    event = 'ColorScheme', pattern = '*',
    callback = function()
      -- highlight ALEVirtualTextWarning term=undercurl cterm=undercurl ctermbg=NONE ctermfg=NONE guifg=#75715e
      vim.api.nvim_set_hl(0, 'ALEVirtualTextWarning', { undercurl = true, sp = "#75715e", bg = "none"})
    end
  }, {
    event = 'ColorScheme', pattern = '*',
    callback = function()
      -- highlight ALEVirtualTextError term=undercurl cterm=undercurl ctermbg=NONE ctermfg=NONE guibg=NONE guibg=NONE gui=undercurl guisp=red
      vim.api.nvim_set_hl(0, 'ALEVirtualTextError', { undercurl = true, sp = "red", bg = "none"})
    end
  }
}

createautocommands(autocommnads)


