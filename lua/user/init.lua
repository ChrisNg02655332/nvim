return {
  lsp = {
    formatting = {
      format_on_save = true, -- enable or disable automatic formatting on save
      disabled = { "lua_ls" },
    },
    tsserver = function(opts)
      opts.root_dir = require("lspconfig.util").root_pattern("package.json")
      return opts
    end,
    -- For eslint:
    eslint = function(opts)
      opts.root_dir = require("lspconfig.util").root_pattern("package.json", ".eslintrc.json", ".eslintrc.js", ".eslintrc")
      return opts
    end, 
    setup_handlers = {
      eslint = function(_, opts)
        require("lspconfig").eslint.setup { 
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end
        } 
      end
    }
  },
  plugins = {
    "jose-elias-alvarez/typescript.nvim", -- add lsp plugin
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "graphql", "heex", "elixir" }
      }
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "tsserver", "eslint", "elixirls" }, -- automatically install lsp
      },
    },
  },
}
