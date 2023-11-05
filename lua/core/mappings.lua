local utils = require "core.utils"

vim.keymap.set("n", "<leader>n", "<cmd> enew <CR>", { desc = "New Buffer" })
vim.keymap.set("n", "<tab>", "<cmd> bnex <CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-tab>", "<cmd> bprevious <CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save Buffer" })
vim.keymap.set("n", "<leader>c", function() require("bufdelete").bufdelete(0, false) end, { desc = "Close Buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window Right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window Up" })

-- Lazy git
vim.keymap.set("n", "<leader>gg", function() utils.toggle_term_cmd("lazygit") end, { desc = "ToggleTerm LazyGit" })
