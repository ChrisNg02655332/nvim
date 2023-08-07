return {
	"nvim-lua/plenary.nvim",
	"famiu/bufdelete.nvim",
	"morhetz/gruvbox",
	"nvim-tree/nvim-web-devicons",
	"jose-elias-alvarez/typescript.nvim",

	{
		"lukas-reineke/indent-blankline.nvim",
		init = function()
			require("core.utils").lazy_load("indent-blankline.nvim")
		end,
		opts = require("plugins.configs.others").blankline,
		config = function(_, opts)
			require("indent_blankline").setup(opts)
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		opts = require("plugins.configs.mason"),
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
				config = require("plugins.configs.mason-lspconfig").setup,
			},
			{
				"jay-babu/mason-null-ls.nvim",
				cmd = { "NullLsInstall", "NullLsUninstall" },
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "jose-elias-alvarez/null-ls.nvim" },
				config = require("plugins.configs.null-ls"),
			},
		},
		init = function()
			require("core.utils").load_mappings("lsp")
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
	},

	{
		"onsails/lspkind.nvim",
		opts = require("plugins.configs.others").lspkind,
		config = function(_, opts)
			require("lspkind").init(opts)
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		ft = { "gitcommit", "diff" },
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		opts = {
			signs = {
				add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
				change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
				delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
				topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
				changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
				untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			},
			on_attach = function(bufnr)
				require("core.utils").load_mappings("gitsigns", { buffer = bufnr })
			end,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("core.utils").lazy_load("nvim-treesitter")
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = require("plugins.configs.others").treesitter,
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
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		init = function()
			require("core.utils").load_mappings("toggleterm")
		end,
		opts = require("plugins.configs.others").toggleterm,
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
		opts = require("plugins.configs.others").lualine,
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = require("plugins.configs.others").bufferline,
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
			timeout = 3000,
			render = "compact",
			stages = "slide",
		},
		config = function(_, opts)
			local notify = require("notify")
			notify.setup(opts)
			vim.notify = notify
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		event = "BufReadPost",
		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},
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

	-- Only load whichkey after all the gui
	{
		"folke/which-key.nvim",
		keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
		init = function()
			require("core.utils").load_mappings("whichkey")
		end,
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},
}
