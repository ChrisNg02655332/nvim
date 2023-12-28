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
				local elixir = require("elixir")
				local elixirls = require("elixir.elixirls")

				elixir.setup({
					nextls = { enable = true },
					credo = {},
					elixirls = {
						enable = true,
						settings = elixirls.settings {
							dialyzerEnabled = false,
							enableTestLenses = false,
						},
					}
				})
			end,
		}
	},
	treesitter = {
		ensure_installed = { 'tsx', 'typescript', 'elixir', 'graphql', 'heex' }
	},
	lspconfig = {
		servers = {
			eslint = {},
			jsonls = {},
			tsserver = {},
		},
		formatting = {
			filter = function(client, _bufnr)
				-- Tsserver usually works poorly. Sorry you work with bad languages
				-- You can remove this line if you know what you're doing :)
				if client.name == 'tsserver' then
					return true
				end
			end
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
