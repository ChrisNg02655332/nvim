return {
	options = {
		close_command = function(bufnum)
			require("bufdelete").bufdelete(bufnum, false)
		end,
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
