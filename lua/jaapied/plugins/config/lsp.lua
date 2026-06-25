return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local capabilities = vim.tbl_deep_extend("force", {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities())

      vim.lsp.config('ruby_lsp', {
        capabilities = capabilities,
        cmd = { "ruby-lsp" },
        init_options = {
          formatter = "rubocop",
          linters = { "rubocop" },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = true
            }
          }
        },
        settings = {
          rubyLsp = {
            enabledFeatures = {
              rails = true,
            }
          }
        }
      })

      vim.lsp.enable({ 'ruby_lsp' })
      vim.lsp.enable({ 'stimulus_ls' })

      local sorbet_root = vim.fs.root(0, { 'sorbet/config' })
      if sorbet_root then
        vim.lsp.config('sorbet', {
          capabilities = capabilities,
          cmd = { "bundle", "exec", "srb", "tc", "--disable-watchman", "--lsp" },
          root_dir = sorbet_root,
        })
        vim.lsp.enable({ 'sorbet' })
      end

      vim.lsp.config('html', {
        capabilities = capabilities,
        filetypes = { "html", "eruby" },
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true
        },
        provideFormatter = true
      })

      vim.lsp.enable({ 'html' })

      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = {
          current_line = true
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { noremap = true, silent = true, buffer = args.buf }
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ float = true }) end, opts)
          vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ float = true }) end, opts)
        end
      })
    end
  }
}
