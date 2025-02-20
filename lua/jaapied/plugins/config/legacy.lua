return {
  { 'AndrewRadev/splitjoin.vim', lazy = false },
  { 'chriskempson/base16-vim', lazy = false },
  { 'mechatroner/rainbow_csv' },
  { 'pangloss/vim-javascript' },
  { 'tmux-plugins/vim-tmux' },
  { 'tpope/vim-abolish', lazy = false },
  { 'tpope/vim-commentary', lazy = false },
  { 'tpope/vim-dadbod' },
  { 'tpope/vim-dispatch', lazy = false },
  { 'tpope/vim-markdown' },
  { 'tpope/vim-projectionist', lazy = false },
  { 'tpope/vim-endwise', lazy = false },
  {
    'vim-ruby/vim-ruby',
    lazy = false,
    config = function ()
      -- :h vim-ruby-indent
      vim.g.ruby_indent_block_style = 'do'
      vim.g.ruby_indent_access_modifier_style = 'outdent'
      vim.g.ruby_indent_assignment_style = 'hanging'
      vim.g.ruby_indent_hanging_elements = 1

      -- :h vim-ruby-syntax
      vim.g.ruby_operators = 1
      vim.g.ruby_pseudo_operators = 1
      vim.g.ruby_space_errors = 1
      -- vim.g.ruby_fold = 0
    end
  },
  { 'tpope/vim-bundler' },
  { 'tpope/vim-rails', lazy = false },
  { 'tpope/vim-ragtag', lazy = false },
  { 'tpope/vim-repeat', lazy = false },
  { 'tpope/vim-speeddating', lazy = false },
  { 'tpope/vim-surround', lazy = false },
  { 'tpope/vim-unimpaired', lazy = false },
  { 'itmammoth/doorboy.vim', lazy = false },
  -- 'tpope/vim-fugitive',
  -- {
  --   'wincent/command-t',
  --   lazy = false,
  --   config = function()
  --     require('wincent.commandt').setup()
  --   end
  -- },
  { 'wincent/pinnacle', lazy = false },
  { 'thoughtbot/vim-rspec', lazy = false },
  -- 'mfussenegger/nvim-lint',
}
