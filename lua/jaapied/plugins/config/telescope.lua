return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      pickers = {
        buffers = {
          theme = "ivy"
        },
        live_grep = {
          theme = "ivy"
        },
        find_files = {
          theme = "ivy"
        }
      },
    })
    local keymap_opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<C-p>', ':Telescope find_files<cr>', keymap_opts)
    vim.keymap.set('n', '<C-b>', ':Telescope buffers<cr>', keymap_opts)
    vim.keymap.set('n', '<C-g>', ':Telescope live_grep<cr>', keymap_opts)
  end
}

