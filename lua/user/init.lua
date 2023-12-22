return {
	plugins = {
		{
			"ayu-theme/ayu-vim",
			priority = 1000,
			config = function()
				-- load the colorscheme here
				vim.cmd.colorscheme("ayu")
			end,
		},

		'jose-elias-alvarez/typescript.nvim',

		{
			"elixir-tools/elixir-tools.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			version = "*",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("elixir").setup()
			end,
		}
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
		servers = {
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
