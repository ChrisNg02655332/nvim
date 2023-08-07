local M = {}

M.blankline = {
	indentLine_enabled = 1,
	filetype_exclude = {
		"help",
		"terminal",
		"lazy",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"nvdash",
		"nvcheatsheet",
		"",
	},
	buftype_exclude = { "terminal" },
	show_trailing_blankline_indent = false,
	show_first_indent_level = false,
	show_current_context = true,
	show_current_context_start = true,
}

M.bufferline = {
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

M.lualine = {
	options = {
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = { "filetype" },
	},
}

M.lspkind = {
	mode = "symbol",
	symbol_map = {
		Array = "󰅪",
		Boolean = "⊨",
		Class = "󰌗",
		Constructor = "",
		Key = "󰌆",
		Namespace = "󰅪",
		Null = "NULL",
		Number = "#",
		Object = "󰀚",
		Package = "󰏗",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "󰀬",
		TypeParameter = "󰊄",
		Unit = "",
	},
	menu = {},
}

M.toggleterm = {
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
}

M.treesitter = {
	ensure_installed = { "lua", "vim", "graphql", "heex", "elixir", "typescript" },

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

return M
