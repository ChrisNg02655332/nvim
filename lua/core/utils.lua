local mappings = require "core.mappings"
local user_mappings = {}

local status_ok, loaded_module = pcall(require, "user.mappings")
if status_ok then
	user_mappings = loaded_module
end


local M           = {}

M.get_icon        = function(kind, padding)
	local icon = require("core.icons")[kind]
	return icon and icon .. string.rep(" ", padding or 0) or ""
end

M.load_mappings   = function(section)
	vim.schedule(function()
		local function set_section_map(section_values)
			for mode, mode_values in pairs(section_values) do
				for keybind, mapping_info in pairs(mode_values) do
					vim.keymap.set(mode, keybind, mapping_info[1], mapping_info[2])
				end
			end
		end

		local merge_mappings = M.extend_tbl(mappings, user_mappings)
		set_section_map(merge_mappings[section])
	end)
end

-- This func support lazy git
M.toggle_term_cmd = function(opts)
	local terms = {}
	-- if a command string is provided, create a basic table for Terminal:new() options
	if type(opts) == "string" then
		opts = { cmd = opts, hidden = true }
	end
	local num = vim.v.count > 0 and vim.v.count or 1
	-- if terminal doesn't exist yet, create it
	if not terms[opts.cmd] then
		terms[opts.cmd] = {}
	end
	if not terms[opts.cmd][num] then
		if not opts.count then
			opts.count = vim.tbl_count(terms) * 100 + num
		end
		if not opts.on_exit then
			opts.on_exit = function()
				terms[opts.cmd][num] = nil
			end
		end
		terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
	end
	-- toggle the terminal
	terms[opts.cmd][num]:toggle()
end

M.close_qf        = function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end

	if qf_exists == true then
		vim.cmd "cclose"
		return
	end
end

M.extend_tbl      = function(default, opts)
	opts = opts or {}
	return default and vim.tbl_deep_extend("force", default, opts) or opts
end

return M
