return {
	"famiu/bufdelete.nvim",

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		opts = {
			options = {
				close_command = function(bufnum)
					require("bufdelete").bufdelete(bufnum, false)
				end,
				left_trunc_marker = '',
				right_trunc_marker = '',
				separator_style = "thin",
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		}
	},
}
