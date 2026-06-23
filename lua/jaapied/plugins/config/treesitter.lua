return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { 'RRethy/nvim-treesitter-endwise' },
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'ruby' },
      endwise = { enable = true },
    },
  },
}
