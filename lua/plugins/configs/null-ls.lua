return function()
  require("mason-null-ls").setup({
    ensure_installed = { "stylua", "tsserver", "eslint" },
    handlers = {},
  })

  local null_ls = require("null-ls")
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local completion = null_ls.builtins.completion

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              async = false,
              filter = function()
                return client.name == "null-ls"
              end,
            })
          end,
        })
      end
    end,

    sources = {
      formatting.htmlbeautifier,
      formatting.stylua,
      formatting.mix,
      diagnostics.eslint,
      completion.spell,
    },
  })
end
