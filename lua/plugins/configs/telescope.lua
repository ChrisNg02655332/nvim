require("telescope").setup {
	-- defaults = {
	-- 	file_ignore_patterns = { "node_modules", "dist", "build", "deps", "_build" },
	-- 	mappings = {
	-- 		i = {
	-- 			["<C-u>"] = false,
	-- 			["<C-d>"] = false,
	-- 		},
	-- 	},
	-- },
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown(),
		},
	},
}

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "software-licenses")
require("core.utils").load_mappings("telescope")
