local make_entry = {}

local Path = require "plenary.path"

local devicons = require "nvim-web-devicons"
local entry_display = require("telescope.pickers.entry_display")
local get_icon = require("core.utils").get_icon

local filter = vim.tbl_filter

function make_entry.gen_from_buffer(opts)
	opts = opts or {}
	local default_icons, _ = devicons.get_icon("file", "", { default = true })

	local bufnrs = filter(function(b)
		return 1 == vim.fn.buflisted(b)
	end, vim.api.nvim_list_bufs())

	local max_bufnr = math.max(unpack(bufnrs))
	local bufnr_width = #tostring(max_bufnr)

	local displayer = entry_display.create {
		separator = " ",
		items = {
			{ width = bufnr_width },
			{ width = 1 },
			{ width = vim.fn.strwidth(default_icons) },
			{ remaining = true },
		},
	}

	local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

	local make_display = function(entry)
		local display_bufname = entry.file_name ~= "" and entry.file_name or "[No Name]"

		return displayer {
			{ entry.bufnr,     "TelescopeResultsNumber" },
			{ entry.indicator, "TelescopePreviewExecute" },
			{ entry.devicons,  entry.devicons_highlight },
			display_bufname,
		}
	end

	return function(entry)
		local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
		bufname = Path:new(bufname):normalize(cwd)

		local changed = entry.info.changed == 1 and get_icon("FileModified") or " "
		local indicator = changed

		local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

		return {
			valid = true,
			value = bufname,
			ordinal = entry.bufnr .. " : " .. bufname,
			display = make_display,
			bufnr = entry.bufnr,
			lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
			indicator = indicator,
			devicons = icons,
			devicons_highlight = highlight,
			file_name = bufname,
		}
	end
end

return make_entry
