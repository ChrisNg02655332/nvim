local codeProccessing = require("lualine.component"):extend()

codeProccessing.processing = false
codeProccessing.spinner_index = 1

local spinner_symbols = {
	"⠋",
	"⠙",
	"⠹",
	"⠸",
	"⠼",
	"⠴",
	"⠦",
	"⠧",
	"⠇",
	"⠏",
}
local spinner_symbols_len = 10

-- Initializer
function codeProccessing:init(options)
	codeProccessing.super.init(self, options)

	local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "CodeCompanionRequest*",
		group = group,
		callback = function(request)
			if request.match == "CodeCompanionRequestStarted" then
				self.processing = true
			elseif request.match == "CodeCompanionRequestFinished" then
				self.processing = false
			end
		end,
	})
end

-- Function that runs every time statusline is updated
function codeProccessing:update_status()
	if self.processing then
		self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
		return spinner_symbols[self.spinner_index]
	else
		return nil
	end
end

require("lualine").setup({
	options = {
		component_separators = "|",
		section_separators = "",
		disabled_filetypes = { "toggleterm" },
		ignore_focus = { "neo-tree" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = {
			codeProccessing,
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
