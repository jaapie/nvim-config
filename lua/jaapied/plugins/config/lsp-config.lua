return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function ()
      require("mason").setup()
    end
  },{
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      auto_install = true
    },
    config = function ()
    end
  },{
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function ()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend( "force", {},
                                                vim.lsp.protocol.make_client_capabilities(),
                                                cmp_nvim_lsp.default_capabilities())

      local lspconfig = require("lspconfig")

      lspconfig.ruby_lsp.setup({
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
            -- Enable Rails-specific features
            enabledFeatures = {
              rails = true,
            }
          }
        }
      })

      -- lspconfig.solargraph.setup({
      --   capabilities = capabilities
      -- })

      if vim.fs.root(0, {'sorbet/config'}) then
        lspconfig.sorbet.setup({
          capabilities = capabilities,
          cmd = { "bundle", "exec", "srb", "tc", "--disable-watchman", "--lsp",  vim.fs.root(0, {".git", "Gemfile", "sorbet/config"})},
        })
      end

      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "eruby" },
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true
        },
        provideFormatter = true
      })

      lspconfig.lua_ls.setup({ capabilities = capabilities })

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts) -- Displays hover information about the symbol under the cursor
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts) -- Jump to the definition
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts) -- Jump to declaration
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts) -- Lists all the implementations for the symbol under the cursor
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts) -- Jumps to the definition of the type symbol
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts) -- Lists all the references
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts) -- Displays a function's signature information
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts) -- Renames all references to the symbol under the cursor
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts) -- Selects a code action available at the current cursor position
      vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts) -- Show diagnostics in a floating window
      vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({float = true})<cr>', opts) -- Move to the previous diagnostic
      vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({float = true})<cr>', opts) -- Move to the next diagnostic

      lspconfig.tailwindcss.setup{
        capabilities = capabilities,
        init_options = {
          userLanguages = {
            eruby = "erb",
          },
        },
        handlers = {
          ["tailwindcss/getConfiguration"] = function(_, _, params, _, bufnr, _)
            vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
          end,
        },
        settings = {
          includeLanguages = {
            erb = "html",
            ruby = "html",
          },
          tailwindCSS = {
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            experimental = {
              classRegex = {
                [[class= "([^"]*)]],
                [[class: "([^"]*)]],
                '~H""".*class="([^"]*)".*"""',
                '~F""".*class="([^"]*)".*"""',
              },
            },
            validate = true,
          },
        },
        filetypes = {
          "css",
          "scss",
          "sass",
          "html",
          "heex",
          "elixir",
          "eruby",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "rust",
          "svelte",
        },
      }
    end
  }
}
