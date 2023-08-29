return {
	{
		"akinsho/toggleterm.nvim",
		cmd = { "ToggleTerm", "TermExec" },
		init = function()
			vim.keymap.set('n', '<leader>tf', "<cmd> ToggleTerm direction=float <CR>",
				{ desc = 'ToggleTerm float' })
			vim.keymap.set('n', '<leader>th', "<cmd> ToggleTerm size=10 direction=horizontal <CR>",
				{ desc = 'ToggleTerm horizontal split' })
			vim.keymap.set('n', '<leader>tv', "<cmd> ToggleTerm size=80 direction=vertical <CR>",
				{ desc = 'ToggleTerm vertical split' })
		end,
		opts = {
			size = 10,
			on_create = function()
				vim.opt.foldcolumn = "0"
				vim.opt.signcolumn = "no"
			end,
			open_mapping = [[<F7>]],
			shading_factor = 2,
			direction = "float",
			float_opts = {
				border = "curved",
				highlights = { border = "Normal", background = "Normal" },
			},
		},
	},
}
