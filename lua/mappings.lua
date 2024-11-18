local M = {}

M.general = {
	n = {
		["<leader>n"] = { "<cmd> enew <cr>", { desc = "general new buffer" } },
		["<tab>"] = { "<cmd> bnex <cr>", { desc = "general next buffer" } },
		["<S-tab>"] = { "<cmd> bprevious <cr>", { desc = "general prev buffer" } },
		["<C-s>"] = { "<cmd> up <cr>", { desc = "general save buffer" } },
		["<C-a>"] = { "ggVG", { desc = "general select all" } },
		["D"] = { vim.diagnostic.open_float, { desc = "general show diagnostic error messages" } },
		["<Esc>"] = { "<cmd>noh<cr>", { desc = "general clear highligh" } },
		["<PageUp>"] = { "<ESC>^i", { desc = "general move beginning of line" } },
		["<leader>b"] = {
			function()
				if vim.g.disable_autoformat then
					vim.cmd("FormatEnable")
				else
					vim.cmd("FormatDisable")
				end
			end,
			{ desc = "general toggle format on save" },
		},
	},

	i = {
		["<PageUp>"] = { "<ESC>^i", { desc = "general move beginning of line" } },
		["<C-h>"] = { "<Left>", { desc = "move left" } },
		["<C-l>"] = { "<Right>", { desc = "move right" } },
		["<C-j>"] = { "<Down>", { desc = "move down" } },
		["<C-k>"] = { "<Up>", { desc = "move up" } },
	},

	t = {
		["<C-/>"] = { "<C-\\><C-N>", { desc = "terminal escape terminal mode" } },
	},
}

M.bdelete = {
	n = {
		["<leader>x"] = { "<cmd> lua require('bufdelete').bufdelete(0, false) <cr>", { desc = "bdelete close buffer" } },
	},
}

M.comment = {
	n = {
		["<leader>/"] = { "gcc", { desc = "comment or uncomment", remap = true } },
	},
	v = {
		["<leader>/"] = { "gc", { desc = "comment or uncomment", remap = true } },
	},
}

M.gitsigns = {
	n = {
		["<leader>gb"] = { "<cmd> Gitsigns blame_line <cr>", { desc = "gitsigns blame line" } },
	},
}

M.telescope = {

	n = {
		["<leader><space>"] = { "<cmd> Telescope buffers <cr>", { desc = "telescope find buffers" } },
		["<leader>sf"] = { "<cmd> Telescope find_files <cr>", { desc = "telescope find files" } },
		["<leader>sg"] = { "<cmd> Telescope live_grep <cr>", { desc = "telescope live grep" } },
	},
}

M.trouble = {
	n = {
		["<leader>ds"] = { "<cmd> Trouble diagnostics <cr>", { desc = "trouble diagnostics loclist" } },
	},
}

M.whichkey = {
	n = {
		["<leader>wK"] = { "<cmd> WhichKey <cr>", { desc = "whichkey all keymaps" } },
		["<leader>wk"] = {
			function()
				vim.cmd("Whichkey " .. vim.fn.input("WhichKey: "))
			end,
			{ desc = "whichkey query lookup" },
		},
	},
}

return M
