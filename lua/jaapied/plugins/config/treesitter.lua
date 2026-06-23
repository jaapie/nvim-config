return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'ruby' },
        endwise = { enable = true },
      })
    end
  },
  { 'RRethy/nvim-treesitter-endwise' },
}
