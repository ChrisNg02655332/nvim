local utils = require("core.utils")

return {
	"tpope/vim-sleuth",

	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
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
		event = "VeryLazy",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
			utils.load_mappings("gitsigns")
		end
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
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"famiu/bufdelete.nvim",
		init = function() utils.load_mappings("bdelete") end
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
			utils.load_mappings("comment")
		end
	},

	{ 'stevearc/dressing.nvim', opts = {} },

	{
		'lukas-reineke/indent-blankline.nvim',
		opts = { indent = { char = '┊' } },
		main = 'ibl',
	},

	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				theme                = require("themes.lualine"),
				component_separators = '|',
				section_separators   = '',
				disabled_filetypes   = { 'toggleterm' }
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
		init = function() utils.load_mappings("neotree") end,
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
		init = function()
			utils.load_mappings("toggleterm")
		end
	},

	{
		'kevinhwang91/nvim-ufo',
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async"
		},
		init = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		config = function()
			local options = require("plugins.configs.ufo")
			require("ufo").setup(options)

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
