return function()
  local opts = {
    ensure_installed = { "lua_ls", "html", "graphql", "tailwindcss", "tsserver", "elixirls", "eslint" },
    automatic_installation = true,
  }

  local lspconfig = require "lspconfig"

  require("mason").setup()
  require("mason-lspconfig").setup(opts)
  require("mason-lspconfig").setup_handlers {
    function(server_name) lspconfig[server_name].setup {} end,

    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }
    end,

    ["eslint"] = function()
      lspconfig.eslint.setup {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end
      }
    end
  }
end
