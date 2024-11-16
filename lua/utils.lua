local M = {}

M.merge_tb = function(...)
	return vim.tbl_deep_extend("force", ...)
end

M.load_mappings = function(section)
		local mappings = require("mappings")

		local function set_section_map(section_values)
			for mode, mode_values in pairs(section_values) do
				for keybind, mapping_info in pairs(mode_values) do
					vim.keymap.set(mode, keybind, mapping_info[1], mapping_info[2])
				end
			end
		end

		if mappings[section] then
			set_section_map(mappings[section])
		else
			vim.notify("[Error] Could not load mappings [" .. section .. "] !")
		end
end

M.load_all_mappings = function()
	for tb, _ in pairs(require("mappings")) do
		M.load_mappings(tb)
	end
end

return M
