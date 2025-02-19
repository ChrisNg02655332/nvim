local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local totalLines = vim.api.nvim_buf_line_count(0)
	local foldedLines = endLnum - lnum
	local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
	suffix = (" "):rep(rAlignAppndx) .. suffix
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

local ufo = require("ufo")
ufo.setup({
	enable_get_fold_virt_text = true,
	fold_virt_text_handler = handler,
	open_fold_hl_timeout = 400,
	close_fold_kinds_for_ft = {
		default = {},
		json = { "comment" },
		c = { "comment", "region" },
	},
	preview = {
		win_config = {
			border = { "", "─", "", "", "", "─", "", "" },
			winhighlight = "Normal:Folded",
			winblend = 0,
		},
		mappings = {
			scrollU = "<C-u>",
			scrollD = "<C-d>",
			jumpTop = "[",
			jumpBot = "]",
		},
	},
})

vim.keymap.set("n", "f", function()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end)
