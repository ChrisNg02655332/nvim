require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "deps", "_build" },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
require("core.utils").load_mappings("telescope")
