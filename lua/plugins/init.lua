return {
	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',
	'stevearc/dressing.nvim',
	'famiu/bufdelete.nvim',
	{ 'folke/which-key.nvim', opts = {} },

	'jose-elias-alvarez/typescript.nvim',

	{
		'rebelot/kanagawa.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'kanagawa-dragon'
		end,
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
			vim.keymap.set('n', '<leader>/', require('Comment.api').toggle.linewise.current,
				{ desc = 'Toggle Comment' })
			vim.keymap.set('v', '<leader>/',
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
				{ desc = 'Toggle Comment' })
		end
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
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			indent = {
				char = '┊',
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
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
		},
		config = function()
			require "plugins.configs.telescope"
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


}
