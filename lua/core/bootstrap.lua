local config = require("core.default_config")

local M = {}

M.echo = function(str)
	vim.cmd("redraw")
	vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

M.lazy = function()
	local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(install_path) then
		--------- lazy.nvim ---------------
		M.echo("  Installing lazy.nvim & plugins ...")

		local repo = "https://github.com/folke/lazy.nvim.git"
		vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path })
	end

	vim.opt.rtp:prepend(install_path)

	-- install plugins
	require("plugins")

	require("lazy.core.util").try(function()
		vim.cmd.colorscheme(config.ui.theme)
	end)
end

return M
