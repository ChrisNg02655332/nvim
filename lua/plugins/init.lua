local utils = require("core.utils")

return {
	"tpope/vim-sleuth",

	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme nightfox]])
		end,
	},

	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
		config = function()
			require 'plugins.configs.mason-lspconfig'
		end
	},


	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
		config = function()
			require 'plugins.configs.cmp'
		end
	},

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
		config = function()
			require 'plugins.configs.treesitter'
		end
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sudormrfbin/cheatsheet.nvim',
			"nvim-tree/nvim-web-devicons",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			"chip/telescope-software-licenses.nvim",
		},
		config = function()
			require "plugins.configs.telescope"
		end
	},

	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then
						return ']c'
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then
						return '[c'
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
			end,
		},
	},

	{
		"windwp/nvim-autopairs",
		-- Optional dependency
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require("nvim-autopairs").setup {}
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end,
	},

	{
		"famiu/bufdelete.nvim",
		init = function() utils.load_mappings("BDelete") end
	},

	{
		'numToStr/Comment.nvim',
		keys = {
			{ 'gcc', mode = 'n',          desc = 'Comment toggle current line' },
			{ 'gc',  mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
			{ 'gc',  mode = 'x',          desc = 'Comment toggle linewise (visual)' },
			{ 'gbc', mode = 'n',          desc = 'Comment toggle current block' },
			{ 'gb',  mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
			{ 'gb',  mode = 'x',          desc = 'Comment toggle blockwise (visual)' },
		},
		init = function()
			utils.load_mappings("Comment")
		end
	},

	{ 'stevearc/dressing.nvim', opts = {} },

	{
		'lukas-reineke/indent-blankline.nvim',
		opts = { indent = { char = '┊' } },
		config = function(_, opts)
			require("ibl").setup(opts)
		end
	},

	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				component_separators = '|',
				section_separators = '',
				disabled_filetypes = { 'toggleterm' }
			},
			sections = {
				lualine_c = {
					{
						'filename',
						cond = function()
							return vim.bo.filetype ~= 'neo-tree'
						end
					}
				},
				lualine_x = {
					{
						'fileformat',
						symbols = {
							unix = vim.fn.has('macunix') == 1 and '' or '', -- e712
							dos = '', -- e70f
							mac = '', -- e711
						}
					},
				},
			}
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		init = function() utils.load_mappings("Neotree") end,
		opts = require("plugins.configs.neotree"),
		config = function(_, opts)
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
			require("neo-tree").setup(opts)
		end
	},

	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "<leader>ss", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
			{ "<leader>sq", "<cmd>TodoQuickFix<cr>",  desc = "Todo Quick Fix" },
		},
	},

	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		opts = {
			size = 10,
			on_create = function()
				vim.opt.foldcolumn = "0"
				vim.opt.signcolumn = "no"
			end,
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "curved",
				highlights = { border = "Normal", background = "Normal" },
			},
		},
		init = utils.load_mappings("Term")
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup(
						{
							relculright = true,
							segments = {
								{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
								{ text = { "%s" },                  click = "v:lua.ScSa" },
								{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
							}
						}
					)
				end
			}
		},
		init = function()
			-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		options = function() require("plugins.configs.ufo") end,
		config = function(_, opts)
			opts["fold_virt_text_handler"] = handler
			require("ufo").setup(opts)

			vim.keymap.set("n", "f", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
		end
	},

	{ 'folke/which-key.nvim',   opts = {} },
}
