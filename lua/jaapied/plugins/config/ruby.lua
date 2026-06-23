return {
  {
    'vim-ruby/vim-ruby',
    lazy = false,
    config = function()
      -- :h vim-ruby-indent
      vim.g.ruby_indent_block_style = 'do'
      vim.g.ruby_indent_access_modifier_style = 'outdent'
      vim.g.ruby_indent_assignment_style = 'hanging'
      vim.g.ruby_indent_hanging_elements = 1

      -- :h vim-ruby-syntax
      vim.g.ruby_operators = 1
      vim.g.ruby_pseudo_operators = 1
      vim.g.ruby_space_errors = 1
    end
  },
  { 'tpope/vim-rails', lazy = false },
  { 'tpope/vim-bundler' },
  {
    'thoughtbot/vim-rspec',
    lazy = false,
    config = function()
      vim.g.rspec_command = '!bundle exec rspec {spec}'
    end
  },
  { 'tpope/vim-projectionist', lazy = false },
}
