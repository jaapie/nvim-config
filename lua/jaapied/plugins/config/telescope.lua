return {
  'nvim-telescope/telescope.nvim',
  -- tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
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
          theme = "ivy",
          hidden = true
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      },
    })
    require('telescope').load_extension('fzf')
    local keymap_opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<C-p>', ':Telescope find_files<cr>', keymap_opts)
    vim.keymap.set('n', '<C-b>', ':Telescope buffers<cr>', keymap_opts)
    vim.keymap.set('n', '<C-g>', ':Telescope live_grep<cr>', keymap_opts)
  end
}

