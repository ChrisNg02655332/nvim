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
  dap = {
    adapters = {
      node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      },
      chrome = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
      }
    },
    configurations = {
      javascript = {
        {
          name = "Node.js",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
      },
      javascript = {
        {
          name = "Chrome (9222)",
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      },
      javascriptreact = {
        {
          name = "Chrome (9222)",
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
      },
      typescriptreact = {
        {
          name = "Chrome (9222)",
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}",
        },
        {
          name = "React Native (8081) (Node2)",
          type = "node2",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          port = 8081,
        },
        -- {
        --   name = "Attach React Native (8081)",
        --   type = "pwa-node",
        --   request = "attach",
        --   processId = function() return require('dap.utils').pick_process end,
        --   cwd = vim.fn.getcwd(),
        --   rootPath = '${workspaceFolder}',
        --   skipFiles = { "<node_internals>/**", "node_modules/**" },
        --   sourceMaps = true,
        --   protocol = "inspector",
        --   console = "integratedTerminal",
        -- },
      }
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
    
    "mxsdev/nvim-dap-vscode-js",
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "node2", "chrome", "js" },
      }
    },
  },
}
