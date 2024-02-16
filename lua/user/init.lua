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

		-- WARN: need to install `brew install jq`
		{
			"rest-nvim/rest.nvim",
			dependencies = { { "nvim-lua/plenary.nvim" } },
			config = function()
				require("rest-nvim").setup({
					result_split_in_place = true,
					show_headers = false,
				})
				require("core.utils").load_mappings("rest")
			end
		},

		-- WARN: need install `brew install libpq`
		{
			'kristijanhusak/vim-dadbod-ui',
			dependencies = {
				{ 'tpope/vim-dadbod',                     lazy = true },
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

				require("core.utils").load_mappings("db_ui")
			end,
		},
	},
	treesitter = {
		ensure_installed = { 'tsx', 'typescript', 'elixir', 'graphql', 'heex', 'http', 'json' }
	},
	lspconfig = {
		servers = {
			elixirls = {},
			eslint = {},
			jsonls = {},
			tsserver = {},
			tailwindcss = {}
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
			tsserver = function(_, opts)
				require("typescript").setup { server = opts }
			end,
			eslint = function()
				require("lspconfig").eslint.setup {
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end,
				}
			end,
			tailwindcss = function()
				require 'lspconfig'.tailwindcss.setup {
					init_options = {
						userLanguages = {
							eelixir = "html-eex",
							elixir = "html",
						},
					},
					suggestions = true,
					root_dir = function(fname)
						local root_pattern = require("lspconfig").util.root_pattern(
							"tailwind.config.js",
							"assets/tailwind.config.js"
						)
						return root_pattern(fname)
					end,
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = { "[a-zA-Z]*Class=\"([^']+)\"" }
							}
						},
					},
				}
			end
		}
	}
}
