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
		formatting = {
			filter = function(client, _bufnr)
				-- Tsserver usually works poorly. Sorry you work with bad languages
				-- You can remove this line if you know what you're doing :)
				if client.name == 'tsserver' then
					return
				end
			end
		},

		unsupported = function()
			require 'lspconfig'.sourcekit.setup {}
		end,

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
