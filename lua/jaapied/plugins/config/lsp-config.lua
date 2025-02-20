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
      })

      -- lspconfig.solargraph.setup({
      --   capabilities = capabilities
      -- })

      lspconfig.sorbet.setup({
        capabilities = capabilities,
        cmd = { "srb", "tc", "--disable-watchman", "--lsp",  vim.fs.root(0, {".git", "Gemfile", "sorbet/config"})},
      })

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

      -- local createautocommands = require('jaapied.core.autocommands')
      -- createautocommands({
      -- event = {'LspAttach'},
      -- pattern = '*',
      -- callback = function(ev)
      local bufmap = function(mode, lhs, rhs)
        local opts = {buffer = true}
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Displays hover information about the symbol under the cursor
      bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

      -- Jump to the definition
      bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

      -- Jump to declaration
      bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

      -- Lists all the implementations for the symbol under the cursor
      bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

      -- Jumps to the definition of the type symbol
      bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

      -- Lists all the references
      bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

      -- Displays a function's signature information
      bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

      -- Renames all references to the symbol under the cursor
      bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

      -- Selects a code action available at the current cursor position
      bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

      -- Show diagnostics in a floating window
      bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

      -- Move to the previous diagnostic
      bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

      -- Move to the next diagnostic
      bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
      -- end

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
