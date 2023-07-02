local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("mason-null-ls").setup({
	ensure_installed = { "stylua", "eslint" },
	handlers = {},
})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

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
		formatting.stylua,
		formatting.eslint,
		diagnostics.eslint,
		completion.spell,
	},
})
