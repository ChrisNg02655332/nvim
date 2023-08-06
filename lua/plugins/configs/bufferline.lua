return {
	options = {
		close_command = function(bufnum)
			require("bufdelete").bufdelete(bufnum, true)
		end,
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
