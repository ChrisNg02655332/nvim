return {
	"nvim-lua/plenary.nvim",

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},

	"famiu/bufdelete.nvim",

	-- formatting!
	{
		"stevearc/conform.nvim",
		config = function()
			return require("configs.conform")
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "┊" },
			scope = { highlight = { "Normal" } },
		},
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		version = false,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- {
					-- 	"rafamadriz/friendly-snippets",
					-- 	config = function()
					-- 		require("luasnip.loaders.from_vscode").lazy_load()
					-- 	end,
					-- },
					--
					-- -- autopairing of (){}[] etc
					{
						"windwp/nvim-autopairs",
						opts = {
							fast_wrap = {},
							disable_filetype = { "TelescopePrompt", "vim" },
						},
						config = function(_, opts)
							require("nvim-autopairs").setup(opts)

							-- setup cmp for autopairs
							local cmp_autopairs = require("nvim-autopairs.completion.cmp")
							require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
						end,
					},

					"saadparwaiz1/cmp_luasnip",
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-path",
				},
			},
		},
		config = function()
			require("configs.cmp")
		end,
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("configs.lsp")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("configs.lualine")
		end,
	},

	-- file managing , picker etc
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = function()
			return require("configs.neotree")
		end,
	},

	-- fuzzy finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("configs.telescope")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = function()
			return require("configs.treesitter")
		end,
	},

	{
		"folke/todo-comments.nvim",
		opts = { signs = false },
	},

	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			position = "right",
		},
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("configs.ufo")
		end,
	},

	{ "rest-nvim/rest.nvim" },

	{
		"folke/which-key.nvim",
		event = "VimEnter",
		keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		opts = {},
	},
}
