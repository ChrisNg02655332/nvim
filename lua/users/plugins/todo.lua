return {
	{
		"folke/todo-comments.nvim",
		event = "BufEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{ "<leader>ss", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
			{ "<leader>sq", "<cmd>TodoQuickFix<cr>",  desc = "Todo Quick Fix" },
		},
	},
}
