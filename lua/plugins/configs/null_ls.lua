local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("mason-null-ls").setup({
  ensure_installed = { "lua_ls" },
  handlers = {},

})

local null_ls = require("null-ls")
null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,

  sources = {
    -- Anything not supported by mason.
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
  }
})
