return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      cmd = { "/home/jake/.rbenv/shims/erblint" },
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.erb_lint,
        -- null_ls.builtins.formatting.rubyfmt,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
