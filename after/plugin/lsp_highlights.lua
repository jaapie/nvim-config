-- DiagnosticUnderlineError xxx cterm=underline gui=underline guisp=Red
-- DiagnosticUnderlineWarn xxx cterm=underline gui=underline guisp=Orange
-- DiagnosticUnderlineInfo xxx cterm=underline gui=underline guisp=LightBlue
-- DiagnosticUnderlineHint xxx cterm=underline gui=underline guisp=LightGrey
-- DiagnosticUnderlineOk xxx cterm=underline gui=underline guisp=LightGreen

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineOk', { undercurl = true, sp = 'LightGreen' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = 'LightGrey' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = 'LightBlue' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = 'Orange' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = 'Red' })

