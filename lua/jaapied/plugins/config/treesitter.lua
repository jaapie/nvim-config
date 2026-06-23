return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { 'RRethy/nvim-treesitter-endwise' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'ruby' },
        endwise = { enable = true },
      })
    end,
  },
}
