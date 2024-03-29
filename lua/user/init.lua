return {
  plugins = {
    {
      'ayu-theme/ayu-vim',
      priority = 1000,
      config = function()
        -- load the colorscheme here
        vim.cmd.colorscheme 'ayu'
      end,
    },

    -- Autoformat
    {
      'stevearc/conform.nvim',
      opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true }
          return {
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { { 'prettierd', 'prettier' } },
          typescript = { { 'prettier', 'eslint' } },
          svelte = { 'prettierd' },
        },
      },
    },

    -- WARN: need to install `brew install jq`
    {
      'vhyrro/luarocks.nvim',
      priority = 1000,
      config = true,
    },
    {
      'rest-nvim/rest.nvim',
      ft = 'http',
      dependencies = { 'luarocks.nvim' },
      config = function()
        require('rest-nvim').setup()
        require('core.utils').load_mappings 'rest'
      end,
    },

    -- WARN: need install `brew install libpq`
    {
      'kristijanhusak/vim-dadbod-ui',
      dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
      },
      cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
      },
      init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1

        require('core.utils').load_mappings 'db_ui'
      end,
    },
  },
  treesitter = {
    ensure_installed = { 'tsx', 'typescript', 'elixir', 'graphql', 'heex', 'http', 'json' },
  },
  lspconfig = {
    servers = {
      elixirls = {},
      jsonls = {},
      tsserver = {},
      tailwindcss = {
        init_options = {
          userLanguages = {
            eelixir = 'html-eex',
            elixir = 'html',
          },
        },
        suggestions = true,
        root_dir = function(fname)
          local root_pattern = require('lspconfig').util.root_pattern('tailwind.config.js', 'assets/tailwind.config.js')
          return root_pattern(fname)
        end,
      },
    },
  },
}
