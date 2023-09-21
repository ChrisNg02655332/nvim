local utils = require "core.utils"

vim.keymap.set("n", "<leader>n", "<cmd> enew <CR>", { desc = "New buffer" })
vim.keymap.set("n", "<tab>", "<cmd> bnex <CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-tab>", "<cmd> bprevious <CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>x", function() require("bufdelete").bufdelete(0, false) end, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>X", "<cmd> qa <CR>", { desc = "Force close buffer" })

-- Lazy git
vim.keymap.set("n", "<leader>gg", function() utils.toggle_term_cmd("lazygit") end, { desc = "ToggleTerm lazygit" })

-- Comment
vim.keymap.set("n", "<leader>/", require("Comment.api").toggle.linewise.current, { desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Toggle comment" })

-- Trouble
vim.keymap.set("n", "<leader>lD", function() require("trouble").open() end, { desc = "Open [T]rouble" })
-- vim.keymap.set("n", "<leader>lw", function() require("trouble").open("workspace_diagnostics") end)
-- vim.keymap.set("n", "<leader>ld", function() require("trouble").open("document_diagnostics") end)
-- vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
-- vim.keymap.set("n", "<leader>ll", function() require("trouble").open("loclist") end, { desc = "Open [T]rouble loclist" })
vim.keymap.set("n", "lr", function() require("trouble").open("lsp_references") end,
	{ desc = "Open [T]rouble [LSP] refer" })
