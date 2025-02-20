vim.g.mapleader = ' '

local keymap_opts = { noremap = true, silent = true }

vim.keymap.set('n', 'Y', 'y$', keymap_opts)
vim.keymap.set('n', 'j', 'gj', keymap_opts)
vim.keymap.set('n', 'k', 'gk', keymap_opts)

vim.keymap.set('n', '<up>', '<nop>', keymap_opts)
vim.keymap.set('n', '<down>', '<nop>', keymap_opts)
vim.keymap.set('n', '<left>', '<nop>', keymap_opts)
vim.keymap.set('n', '<right>', '<nop>', keymap_opts)
vim.keymap.set('i', '<up>', '<nop>', keymap_opts)
vim.keymap.set('i', '<down>', '<nop>', keymap_opts)
vim.keymap.set('i', '<left>', '<nop>', keymap_opts)
vim.keymap.set('i', '<right>', '<nop>', keymap_opts)

vim.keymap.set('c', '<C-a>', '<Home>', keymap_opts)
vim.keymap.set('c', '<C-e>', '<End>', keymap_opts)

vim.keymap.set('i', '(<cr>', '(<cr>)<c-o>O')
vim.keymap.set('i', '{<cr>', '{<cr>}<c-o>O')
vim.keymap.set('i', '[<cr>', '[<cr>]<c-o>O')

vim.keymap.set('n', '<c-w>|', ':vsplit<cr>', keymap_opts)
vim.keymap.set('n', '<c-w>-', ':split<cr>', keymap_opts)
vim.keymap.set('n', '<c-h>', '<c-w>h', keymap_opts)
vim.keymap.set('n', '<c-j>', '<c-w>j', keymap_opts)
vim.keymap.set('n', '<c-k>', '<c-w>k', keymap_opts)
vim.keymap.set('n', '<c-l>', '<c-w>l', keymap_opts)
vim.keymap.set('n', '<Leader>e', ":'<,'>lua<cr>", keymap_opts)

vim.keymap.set({ 'n', 'v', 'o' }, '<leader>t', ':call RunCurrentSpecFile()<CR>', keymap_opts)
vim.keymap.set({ 'n', 'v', 'o' }, '<leader>s', ':call RunNearestSpec()<CR>', keymap_opts)
vim.keymap.set({ 'n', 'v', 'o' }, '<leader>l', ':call RunLastSpec()<CR>', keymap_opts)
vim.keymap.set({ 'n', 'v', 'o' }, '<leader>a', ':call RunAllSpecs()<CR>', keymap_opts)

vim.keymap.set({ 'n', 'v', 'o' }, '<leader>n', ':A<CR>', keymap_opts)


