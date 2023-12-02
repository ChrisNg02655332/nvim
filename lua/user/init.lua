return {
	plugins = {
		'jose-elias-alvarez/typescript.nvim',
	},
	lsp = {
		servers = {
			elixirls = {},
			eslint = {},
			jsonls = {},
			tsserver = {},
		},
		setup_handlers = {
			["tsserver"] = function(_, opts)
				require("typescript").setup { server = opts }
			end,

			["eslint"] = function()
				require("lspconfig").eslint.setup {
					on_attach = function(_, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				}
			end,

		}
	}
}
