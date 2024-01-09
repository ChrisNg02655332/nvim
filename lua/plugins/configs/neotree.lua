local utils = require("core.utils")
local get_icon = require("core.utils").get_icon

return {
	auto_clean_after_session_restore = true,
	close_if_last_window = true,
	sources = { "filesystem", "buffers", "git_status" },
	default_component_configs = {
		indent = { padding = 0 },
		icon = {
			folder_closed = get_icon("FolderClosed"),
			folder_open = get_icon("FolderOpen"),
			folder_empty = get_icon("FolderEmpty"),
			folder_empty_open = get_icon("FolderEmpty"),
			default = get_icon("DefaultFile"),
		},
		modified = { symbol = get_icon("FileModified") },
		git_status = {
			symbols = {
				added = get_icon("GitAdd"),
				deleted = get_icon("GitDelete"),
				modified = get_icon("GitChange"),
				renamed = get_icon("GitRenamed"),
				untracked = get_icon("GitUntracked"),
				ignored = get_icon("GitIgnored"),
				unstaged = get_icon("GitUnstaged"),
				staged = get_icon("GitStaged"),
				conflict = get_icon("GitConflict"),
			},
		},
	},
	commands = {
		parent_or_close = function(state)
			local node = state.tree:get_node()
			if (node.type == "directory" or node:has_children()) and node:is_expanded() then
				state.commands.toggle_node(state)
			else
				require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
			end
		end,
		child_or_open = function(state)
			local node = state.tree:get_node()
			if node.type == "directory" or node:has_children() then
				if not node:is_expanded() then -- if unexpanded, expand
					state.commands.toggle_node(state)
				else                       -- if expanded and has children, seleect the next child
					require("neo-tree.ui.renderer").focus_node(state,
						node:get_child_ids()[1])
				end
			else -- if not a directory just open it
				state.commands.open(state)
			end
		end,
		copy_selector = function(state)
			local node = state.tree:get_node()
			local filepath = node:get_id()
			local filename = node.name
			local modify = vim.fn.fnamemodify

			local results = {
				e = { val = modify(filename, ":e"), msg = "Extension only" },
				f = { val = filename, msg = "Filename" },
				F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
				h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
				p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
				P = { val = filepath, msg = "Absolute path" },
			}

			local messages = {
				{ "\nChoose to copy to clipboard:\n", "Normal" },
			}
			for i, result in pairs(results) do
				if result.val and result.val ~= "" then
					vim.list_extend(messages, {
						{ ("%s."):format(i),           "Identifier" },
						{ (" %s: "):format(result.msg) },
						{ result.val,                  "String" },
						{ "\n" },
					})
				end
			end
			vim.api.nvim_echo(messages, false, {})
			local result = results[vim.fn.getcharstr()]
			if result and result.val and result.val ~= "" then
				utils.notify(("Copied: `%s`"):format(result.val))
				vim.fn.setreg("+", result.val)
			end
		end,
		find_in_dir = function(state)
			local node = state.tree:get_node()
			local path = node:get_id()
			require("telescope.builtin").find_files({
				cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
			})
		end,
	},

	cwd_target = "none",
	popup_border_style = "single",
	window = {
		width = 30,
		mappings = {
			["<space>"] = false, -- disable space until we figure out which-key disabling
			["[b"] = "prev_source",
			["]b"] = "next_source",
			Y = "copy_selector",
			h = "parent_or_close",
			l = "child_or_open",
			o = "open",
		},
		fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
			["<C-j>"] = "move_cursor_down",
			["<C-k>"] = "move_cursor_up",
		},
	},
	filesystem = {
		follow_current_file = { enabled = true },
		hijack_netrw_behavior = "open_current",
		use_libuv_file_watcher = true,
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function(_)
				vim.opt_local.signcolumn = "auto"
			end,
		},
	},
}
