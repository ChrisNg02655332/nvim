local map = vim.keymap.set

-- general
map("n", "<leader>n", "<cmd> enew <cr>", { desc = "general new buffer" })
map("n", "<tab>", "<cmd> bnex <cr>", { desc = "general next buffer" })
map("n", "<S-tab>", "<cmd> bprevious <cr>", { desc = "general prev buffer" })
map("n", "<C-s>", "<cmd> up <cr>", { desc = "general save buffer" })
map("n", "<C-a>", "ggVG", { desc = "general select all" })
map("n", "D", vim.diagnostic.open_float, { desc = "general show diagnostic error messages" })
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "general clear highligh" })
map("n", "<PageUp>", "<ESC>^i", { desc = "general move beginning of line" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<leader>b", function()
	if vim.g.disable_autoformat then
		vim.cmd("FormatEnable")
	else
		vim.cmd("FormatDisable")
	end
end, { desc = "general toggle format on save" })

map("i", "<PageUp>", "<ESC>^i", { desc = "general move beginning of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("t", "<C-/>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- bdelete
map("n", "<leader>x", "<cmd> lua require('bufdelete').bufdelete(0, false) <cr>", { desc = "bdelete close buffer" })

-- comment
map("n", "<leader>/", "gcc", { desc = "comment or uncomment", remap = true })

map("v", "<leader>/", "gc", { desc = "comment or uncomment", remap = true })

-- gitsigns
map("n", "<leader>gb", "<cmd> Gitsigns blame_line <cr>", { desc = "gitsigns blame line" })

-- symbol-ouline
map("n", "<leader>so", "<cmd> SymbolsOutline <cr>", { desc = "symbol outline toggle" })

-- telescope
map("n", "<leader><space>", "<cmd> Telescope buffers <cr>", { desc = "telescope find buffers" })
map("n", "<leader>sf", "<cmd> Telescope find_files <cr>", { desc = "telescope find files" })
map("n", "<leader>sg", "<cmd> Telescope live_grep <cr>", { desc = "telescope live grep" })

-- trouble
map("n", "<leader>ss", "<cmd> Trouble diagnostics <cr>", { desc = "trouble diagnostics loclist" })

-- whichkey
map("n", "<leader>wK", "<cmd> WhichKey <cr>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
	vim.cmd("Whichkey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })
