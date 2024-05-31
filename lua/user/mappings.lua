local M = {}

M.db_ui = {
	n = {
		["<leader>w"] = { "<cmd> DBUIToggle <cr>", { desc = "DBUI Toggle " } },
	},
}

M.rest = {
	n = {
		["<leader>r"] = { "<cmd>Rest run<cr>", { desc = "Run rest" } },
	},
}

return M
