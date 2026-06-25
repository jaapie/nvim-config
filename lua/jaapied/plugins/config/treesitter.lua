return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      if vim.fn.executable('tree-sitter') == 0 then
        vim.notify('tree-sitter CLI not found — run: npm install -g tree-sitter-cli', vim.log.levels.WARN)
        return
      end
      local installed = require('nvim-treesitter.config').get_installed()
      if not vim.tbl_contains(installed, 'ruby') then
        require('nvim-treesitter').install('ruby')
      end
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'ruby',
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  { 'RRethy/nvim-treesitter-endwise', lazy = false },
}
