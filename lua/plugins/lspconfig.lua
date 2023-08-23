return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = { "LspInstall", "LspUninstall" },
        opts = {
          ensure_installed = {
            "lua_ls",
            "jsonls",
            "graphql",
            "tsserver",
            "tailwindcss",
            "elixirls",
            "eslint",
          },
        },
        config = function(_, opts)
          local lspconfig = require("lspconfig")
          local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

          require("mason").setup()
          require("mason-lspconfig").setup(opts)
          require("mason-lspconfig").setup_handlers({
            function(server_name)
              lspconfig[server_name].setup({
                capabilities = lsp_capabilities,
              })
            end,

            ["lua_ls"] = function()
              lspconfig.lua_ls.setup({
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { "vim" },
                    },
                    workspace = {
                      library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                      },
                      maxPreload = 100000,
                      preloadFileSize = 10000,
                    },
                  },
                },
              })
            end,

            ["tsserver"] = function()
              require("typescript").setup({ server = opts })
            end,

            ["eslint"] = function()
              lspconfig.eslint.setup({
                on_attach = function(_, bufnr)
                  vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    command = "EslintFixAll",
                  })
                end,
              })
            end,
          })
        end,
      },
    },
    -- init = function()
    --   require("core.utils").load_mappings("lsp")
    --   require("core.utils").lazy_load("nvim-lspconfig")
    -- end,
    config = function()
      -- Switch for controlling whether you want autoformatting.
      local format_is_enabled = true
      -- vim.api.nvim_create_user_command("FormatToggle", function()
      -- 	format_is_enabled = not format_is_enabled
      -- 	print("Setting autoformatting to: " .. tostring(format_is_enabled))
      -- end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --  We need one augroup per client to make sure that multiple clients
      --  can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = "lsp-format-" .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == "tsserver" then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format({
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              })
            end,
          })
        end,
      })
    end
  },

  {
    "onsails/lspkind.nvim",
    opts = {
      mode = "symbol",
      symbol_map = {
        Array = "󰅪",
        Boolean = "⊨",
        Class = "󰌗",
        Constructor = "",
        Key = "󰌆",
        Namespace = "󰅪",
        Null = "NULL",
        Number = "#",
        Object = "󰀚",
        Package = "󰏗",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "󰀬",
        TypeParameter = "󰊄",
        Unit = "",
      },
      menu = {},
    },
    config = function(_, opts)
      require("lspkind").init(opts)
    end,
  },
}
