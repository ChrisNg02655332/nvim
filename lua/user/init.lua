return {
  colorscheme = "nightfox",
  lsp = {
    formatting = {
      format_on_save = true, -- enable or disable automatic formatting on save
      disabled = { "lua_ls", "tsserver", "eslint" },
    },
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
    "EdenEast/nightfox.nvim",
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = { "graphql", "heex", "elixir" }
      }
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "tsserver", "eslint", "elixirls", "jsonls" }, -- automatically install lsp
      },
    },
  },
}
