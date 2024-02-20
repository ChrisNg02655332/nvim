local M = {}

M.db_ui = {
	n = {
		["<leader>w"] = { "<cmd> DBUIToggle <cr>", { desc = "DBUI Toggle " } }
	}
}

M.rest = {
	n = {
		["<leader>r"] = { "<Plug>RestNvim", { desc = "Run rest" } }
	}
}

return M
