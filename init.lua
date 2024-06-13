vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Enable lualine whole screen
vim.o.laststatus = 3

-- Enable fold
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- See `:help vim.keymap.set()`
-- vim.keymap.set({'n', 'i'}, '∆', rhs)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("t", "<C-/>", "<C-\\><C-n><C-w>h", { silent = true })
vim.keymap.set("i", "<C-h>", "<left>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<down>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<up>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<right>", { noremap = true })

-------------------------------------- autocmds ------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local toggle_term_cmd = function(opts)
	local terms = {}
	-- if a command string is provided, create a basic table for Terminal:new() options
	if type(opts) == "string" then
		opts = { cmd = opts, hidden = true }
	end
	local num = vim.v.count > 0 and vim.v.count or 1
	-- if terminal doesn't exist yet, create it
	if not terms[opts.cmd] then
		terms[opts.cmd] = {}
	end
	if not terms[opts.cmd][num] then
		if not opts.count then
			opts.count = vim.tbl_count(terms) * 100 + num
		end
		if not opts.on_exit then
			opts.on_exit = function()
				terms[opts.cmd][num] = nil
			end
		end
		terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
	end
	-- toggle the terminal
	terms[opts.cmd][num]:toggle()
end

--------------------------------------- mappings -------------------------------------------
local mappings = {
	general = {
		n = {
			-- Remap for dealing with word wrap
			["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
			["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

			["<leader>n"] = { "<cmd> enew <cr>", { desc = "New Buffer" } },

			["<tab>"] = { "<cmd> bnex <cr>", { desc = "Next Buffer" } },
			["<S-tab>"] = { "<cmd> bprevious <cr>", { desc = "Prev Buffer" } },
			["<C-s>"] = { "<cmd> up <cr>", { desc = "Save Buffer" } },

			["<leader>q"] = { "<cmd> q <cr>", { desc = "Quit without save" } },
			["<leader>Q"] = { "<cmd> q! <cr>", { desc = "Force quit without save" } },

			["K"] = { "<cmd> move -2 <cr>", { desc = "Move line up" } },
			["J"] = { "<cmd> move +1 <cr>", { desc = "Move line down" } },

			["<C-a>"] = { "ggVG", { desc = "Select all" } },
			["<PageUp>"] = { "^", { desc = "Move the cursor to the first non-blank character of a line" } },

			["D"] = { vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" } },
		},

		i = {
			["<PageUp>"] = { "<Esc>^ | I", { desc = "Move the cursor to the first non-blank character of a line" } },
		},
	},
	bdelete = {
		n = {
			["<leader>x"] = {
				function()
					require("bufdelete").bufdelete(0, false)
				end,
				{ desc = "Close Buffer" },
			},
		},
	},
	comment = {
		n = {
			["<leader>/"] = {
				function()
					require("Comment.api").toggle.linewise.current()
				end,
				{ desc = "Toggle Comment" },
			},
		},

		v = {
			["<leader>/"] = {
				"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
				{ desc = "Toggle Comment" },
			},
		},
	},
	db_ui = {
		n = {
			["<leader>w"] = { "<cmd> DBUIToggle <cr>", { desc = "DBUI Toggle " } },
		},
	},
	gitsigns = {
		n = {
			["<leader>gb"] = { "<cmd> Gitsigns blame_line<cr>", { desc = "[G]it [B]lame" } },
			["<leader>gh"] = { "<cmd> Gitsigns preview_hunk <cr>", { desc = "[P]review [H]unk" } },
			["<leader>gd"] = { "<cmd> Gitsigns diffthis <cr>", { desc = "[G]it [D]iff" } },
		},
	},
	rest = {
		n = {
			["<leader>r"] = { "<cmd>Rest run<cr>", { desc = "Run rest" } },
		},
	},
	telescope = {
		n = {
			["<leader>sb"] = { "<cmd>Telescope oldfiles<cr>", { desc = "[?] Find recently opened files" } },
			["<leader><space>"] = { "<cmd>Telescope buffers<cr>", { desc = "[ ] Find existing buffers" } },
			["<leader>gf"] = { "<cmd>Telescope git_files<cr>", { desc = "[S]earch [G]it [F]iles" } },
			["<leader>sf"] = { "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" } },
			["<leader>sg"] = { "<cmd>Telescope live_grep<cr>", { desc = "[S]earch [G]rev" } },
			["<leader>sw"] = { "<cmd>Telescope grep_string<cr>", { desc = "[S]earch [C]urrent [W]ord" } },
			["<leader>sd"] = { "<cmd>Telescope diagnostics<cr>", { desc = "[S]earch [D]iagnostics" } },
			["<leader>sc"] = { "<cmd> Cheatsheet <cr>", { desc = "Search Cheatsheet" } },
		},
	},
	toggleterm = {
		n = {
			["<leader>gg"] = {
				function()
					toggle_term_cmd({ cmd = "lazygit", direction = "float" })
				end,
				{ desc = "ToggleTerm LazyGit" },
			},
			["<C-/>"] = { "<cmd> ToggleTerm direction=float <cr>", { desc = "ToggleTerm float" } },
		},
	},
	trouble = {
		n = {
			["<leader>st"] = { "<cmd>TroubleToggle<cr>", { desc = "[T]rouble [T]oggle" } },
		},
	},
}

--------------------------------------- helpers --------------------------------------------

local load_mappings = function(section)
	vim.schedule(function()
		local function set_section_map(section_values)
			for mode, mode_values in pairs(section_values) do
				for keybind, mapping_info in pairs(mode_values) do
					vim.keymap.set(mode, keybind, mapping_info[1], mapping_info[2])
				end
			end
		end

		if mappings[section] then
			set_section_map(mappings[section])
		else
			vim.notify("[Error] Could not load mappings folder!")
		end
	end)
end

load_mappings("general")

-------------------------------------- setup lazy ------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- colorscheme
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_transparent_background = 2
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},

	-- alpha
	{
		"goolord/alpha-nvim",
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local theta = require("alpha.themes.theta")

			local buttons = {
				type = "group",
				val = {
					{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
					{ type = "padding", val = 1 },
					dashboard.button("e", "  New file", "<cmd>ene<CR>"),
					dashboard.button("SPC s f", "󰈞  Find file"),
					dashboard.button("SPC s g", "󰊄  Live grep"),
					dashboard.button("c", "  Configuration", "<cmd>open ~/.config/nvim/ <CR>"),
					dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
					dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
				},
				position = "center",
			}

			local opts = {
				layout = {
					{ type = "padding", val = 2 },
					theta.header,
					{ type = "padding", val = 2 },
					theta.section_mru,
					{ type = "padding", val = 2 },
					buttons,
				},
				opts = {
					margin = 5,
					setup = function()
						vim.api.nvim_create_autocmd("DirChanged", {
							pattern = "*",
							group = "alpha_temp",
							callback = function()
								require("alpha").redraw()
								vim.cmd("AlphaRemap")
							end,
						})
					end,
				},
			}

			require("alpha").setup(opts)
		end,
	},

	-- bdelete
	{
		"famiu/bufdelete.nvim",
		init = function()
			load_mappings("bdelete")
		end,
	},

	-- cmp
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			"rafamadriz/friendly-snippets",
		},
		opts = {},
	},

	-- comment
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
		},
		init = function()
			load_mappings("comment")
		end,
	},

	-- conform
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier", "eslint" } },
				svelte = { "prettierd", "prettier" },
			},
		},
	},

	{ "stevearc/dressing.nvim", opts = {} },

	-- indent-blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "┊" },
			scope = { highlight = { "Normal" } },
		},
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("antbase-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("<leader>ca", vim.lsp.buf.code_action, "Hover [C]ode [A]ctions")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbol")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("antbase-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("antbase-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "antbase-lsp-highlight", buffer = event2.buf })
							end,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- neotree
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
		},
		opts = {
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			default_component_configs = {
				indent = { padding = 0 },
				modified = { symbol = "" },
				git_status = {
					symbols = {
						added = "",
						deleted = "",
						modified = "",
						renamed = "➜",
						untracked = "★",
						ignored = "◌",
						unstaged = "✗",
						staged = "✓",
						conflict = "",
					},
				},
			},
			cwd_target = "none",
			popup_border_style = "single",
			commands = {
				parent_or_close = function(state)
					local node = state.tree:get_node()
					if (node.type == "directory" or node:has_children()) and node:is_expanded() then
						state.commands.toggle_node(state)
					else
						require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
					end
				end,
				child_or_open = function(state)
					local node = state.tree:get_node()
					if node.type == "directory" or node:has_children() then
						if not node:is_expanded() then -- if unexpanded, expand
							state.commands.toggle_node(state)
						else -- if expanded and has children, seleect the next child
							require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
						end
					else -- if not a directory just open it
						state.commands.open(state)
					end
				end,
			},
			window = {
				position = "left",
				width = 30,
				mappings = {
					["<space>"] = false,
					h = "parent_or_close",
					l = "child_or_open",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},

	-- nvim-autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- Optional dependency
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				component_separators = "|",
				section_separators = "",
				disabled_filetypes = { "toggleterm" },
			},
			sections = {
				lualine_c = {
					{
						"filename",
						cond = function()
							return vim.bo.filetype ~= "neo-tree"
						end,
					},
				},
				lualine_x = {
					{
						"fileformat",
						symbols = {
							unix = vim.fn.has("macunix") == 1 and "" or "", -- e712
							dos = "", -- e70f
							mac = "", -- e711
						},
					},
				},
			},
		},
	},

	-- ufo
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
				suffix = (" "):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			local ufo = require("ufo")
			ufo.setup({
				fold_virt_text_handler = handler,
				open_fold_hl_timeout = 400,
				close_fold_kinds_for_ft = {
					default = { "imports", "comment" },
					json = { "comment" },
					c = { "comment", "region" },
				},
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
			})

			vim.keymap.set("n", "f", function()
				local winid = ufo.peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
		end,
	},

	-- trouble
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			position = "right",
		},
		init = function()
			load_mappings("trouble")
		end,
	},

	-- gitsigns
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
			load_mappings("gitsigns")
		end,
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sudormrfbin/cheatsheet.nvim",
			"nvim-tree/nvim-web-devicons",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"chip/telescope-software-licenses.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules", "deps", "_build" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
			load_mappings("telescope")
		end,
	},

	-- todo-comments
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			keywords = {
				FIX = {
					alt = { "IMPORTANT" },
				},
			},
		},
		keys = {
			{ "<leader>ss", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
			{ "<leader>sq", "<cmd>TodoQuickFix<cr>", desc = "Todo Quick Fix" },
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)
		end,
	},

	-- toggleterm
	{
		"akinsho/toggleterm.nvim",
		init = function()
			load_mappings("toggleterm")
		end,
		opts = {},
	},

	-- treesister
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		config = function()
			local ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"tsx",
				"typescript",
				"elixir",
				"graphql",
				"heex",
				"http",
				"json",
				"svelte",
			}

			require("nvim-treesitter.configs").setup({
				ensure_installed = ensure_installed,
				autotag = {
					enable = true,
				},
				auto_install = true,
				sync_install = true,
				modules = {},
				ignore_install = {},
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<M-space>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
		end,
	},

	-- WARN: need to install `brew install jq`
	-- it might be display errors when luarocks check dependencies - IGNORE it
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup({
				result = {
					split = {
						in_place = true,
					},
				},
			})
			load_mappings("rest")
		end,
	},

	-- WARN: need install `brew install libpq`
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			load_mappings("db_ui")
		end,
	},

	{ "folke/which-key.nvim", opts = {} },
}

require("lazy").setup(plugins)
