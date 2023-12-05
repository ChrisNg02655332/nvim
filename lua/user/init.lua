return {
	plugins = {
		{
			"EdenEast/nightfox.nvim",
			priority = 1000,
			config = function()
				-- load the colorscheme here
				vim.cmd([[colorscheme nightfox]])
			end,
		},

		'jose-elias-alvarez/typescript.nvim',
	},
	treesitter = {
		ensure_installed = { 'tsx', 'typescript', 'elixir', 'graphql', 'heex' }
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
