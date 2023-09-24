local get_icon = require("core.utils").get_icon

return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		-- init = function()
		-- 	vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { link = 'Normal' })
		-- 	vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitle', { link = 'Normal' })
		-- 	vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { link = 'Normal' })
		-- 	vim.api.nvim_set_hl(0, 'NoiceCompletionItemMenu', { link = 'Normal' })
		-- 	vim.api.nvim_set_hl(0, 'NoiceFormatConfirmDefault', { link = 'Normal' })
		-- 	vim.api.nvim_set_hl(0, 'NoiceConfirmPopupTitle', { link = 'Normal' })
		-- 	vim.api.nvim_set_hl(0, 'NoiceConfirmBorder', { link = 'Normal' })
		-- end,
		opts = {
			cmdline = {
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", icon = ">_", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = get_icon("Search", 1) .. "", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = get_icon("Search", 1) .. "", lang = "regex" },
				}
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = {
					views = {
						cmdline_popup = {
							position = {
								row = 10,
							},
						},
						cmdline_popupmenu = {
							position = {
								row = 13,
							}
						}
					},
				},                        -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false,       -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false,   -- add a border to hover docs and signature help
			},
		},
	},
}
