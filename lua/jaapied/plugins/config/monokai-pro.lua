return {
  "loctvl842/monokai-pro.nvim",
  -- 'chriskempson/base16-vim',
  lazy = false,
  config = function()
    require("monokai-pro").setup({
      filter = "classic"
    })

    -- vim.cmd('colorscheme monokai-pro')
    -- vim.cmd('colorscheme base16-monokai')
  end
}
