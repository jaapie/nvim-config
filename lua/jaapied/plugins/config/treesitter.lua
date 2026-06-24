return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      local installed = require('nvim-treesitter.config').get_installed()
      if not vim.tbl_contains(installed, 'ruby') then
        require('nvim-treesitter').install('ruby')
      end
    end,
  },
  { 'RRethy/nvim-treesitter-endwise', lazy = false },
}
