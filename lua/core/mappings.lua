local utils = require "core.utils"

vim.keymap.set("n", "<leader>n", "<cmd> enew <CR>", { desc = "New Buffer" })
vim.keymap.set("n", "<tab>", "<cmd> bnex <CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-tab>", "<cmd> bprevious <CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save Buffer" })
vim.keymap.set("n", "<leader>c", function() require("bufdelete").bufdelete(0, false) end, { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>C", "<cmd> qa <CR>", { desc = "Force Close Buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window Right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
-- Lazy git
vim.keymap.set("n", "<leader>gg", function() utils.toggle_term_cmd("lazygit") end, { desc = "ToggleTerm LazyGit" })

-- Comment
vim.keymap.set("n", "<leader>/", require("Comment.api").toggle.linewise.current, { desc = "Toggle Comment" })
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle Comment" })

-- Trouble
vim.keymap.set("n", "<leader>lD", function() require("trouble").open() end, { desc = "Open Trouble" })
-- vim.keymap.set("n", "<leader>lw", function() require("trouble").open("workspace_diagnostics") end)
-- vim.keymap.set("n", "<leader>ld", function() require("trouble").open("document_diagnostics") end)
-- vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
-- vim.keymap.set("n", "<leader>ll", function() require("trouble").open("loclist") end, { desc = "Open [T]rouble loclist" })
vim.keymap.set("n", "lr", function() require("trouble").open("lsp_references") end,
	{ desc = "Open Trouble LSP Refer" })
