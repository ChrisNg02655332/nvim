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

		-- WARN: Need install pgql via postgres or libpq
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
		ensure_installed = { 'tsx', 'typescript', 'elixir', 'graphql', 'heex' }
	},
	lspconfig = {
		servers = {
			elixirls = {},
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
			end
		}
	}
}
