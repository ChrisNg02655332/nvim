return {
	"nvim-lua/plenary.nvim",
	-- "echasnovski/mini.bufremove",
	"famiu/bufdelete.nvim",
	"morhetz/gruvbox",
	"nvim-tree/nvim-web-devicons",
	"jose-elias-alvarez/typescript.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("core.utils").lazy_load("nvim-treesitter")
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "lua", "vim", "graphql", "heex", "elixir", "typescript" },

			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = { store_selection_keys = "<C-x>" },
		config = function(_, opts)
			require("luasnip").config.setup(opts)
			vim.tbl_map(function(type)
				require("luasnip.loaders.from_" .. type).lazy_load()
			end, { "vscode", "snipmate", "lua" })
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)

					vim.tbl_map(function(type)
						require("luasnip.loaders.from_" .. type).lazy_load()
					end, { "vscode", "snipmate", "lua" })

					vim.api.nvim_create_autocmd("InsertLeave", {
						callback = function()
							if
								require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
								and not require("luasnip").session.jump_active
							then
								require("luasnip").unlink_current()
							end
						end,
					})
				end,
			},

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
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = "InsertEnter",
		opts = function()
			return require("plugins.configs.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_uninstalled = "✗",
					package_pending = "⟳",
				},
			},
		},
		build = ":MasonUpdate",
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				cmd = { "LspInstall", "LspUninstall" },
				config = require("plugins.configs.mason-lspconfig"),
			},
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				event = { "BufReadPre", "BufNewFile" },
				dependencies = {
					"jose-elias-alvarez/null-ls.nvim",
				},
				config = require("plugins.configs.null-ls"),
			},
		},
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
	},

	{
		"onsails/lspkind.nvim",
		opts = {
			mode = "symbol",
			symbol_map = {
				Array = "󰅪",
				Boolean = "⊨",
				Class = "󰌗",
				Constructor = "",
				Key = "󰌆",
				Namespace = "󰅪",
				Null = "NULL",
				Number = "#",
				Object = "󰀚",
				Package = "󰏗",
				Property = "",
				Reference = "",
				Snippet = "",
				String = "󰀬",
				TypeParameter = "󰊄",
				Unit = "",
			},
			menu = {},
		},
		config = function(_, opts)
			require("lspkind").init(opts)
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		init = function()
			require("core.utils").load_mappings("toggleterm")
		end,
		opts = function()
			return require("plugins.configs.toggleterm")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Telescope",
		init = function()
			require("core.utils").load_mappings("telescope")
		end,
		config = function()
			require("plugins.configs.telescope")
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "main",
		dependencies = { "MunifTanjim/nui.nvim" },
		cmd = "Neotree",
		init = function()
			vim.g.neo_tree_remove_legacy_commands = true
			require("core.utils").load_mappings("neotree")
		end,
		opts = function()
			return require("plugins.configs.neo-tree")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		opts = function()
			return require("plugins.configs.lualine")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = function()
			return require("plugins.configs.bufferline")
		end,
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},

	{
		"rcarriga/nvim-notify",
		init = function()
			require("core.utils").lazy_load("nvim-notify")
		end,
		opts = {
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 175 })
				if not vim.g.ui_notifications_enabled then
					vim.api.nvim_win_close(win, true)
				end
				if not package.loaded["nvim-treesitter"] then
					pcall(require, "nvim-treesitter")
				end
				vim.wo[win].conceallevel = 3
				local buf = vim.api.nvim_win_get_buf(win)
				if not pcall(vim.treesitter.start, buf, "markdown") then
					vim.bo[buf].syntax = "markdown"
				end
				vim.wo[win].spell = false
			end,
		},
		config = function(_, otps)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},

	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n" },
			{ "gc", mode = "v" },
			{ "gbc", mode = "n" },
			{ "gb", mode = "v" },
		},
		init = function()
			require("core.utils").load_mappings("comment")
		end,
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
}
