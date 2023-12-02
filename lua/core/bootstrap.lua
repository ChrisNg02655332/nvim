_G.antbase = {
	plugins = {},
	lsp = {
		servers = {},
		setup_handlers = {}
	}
}

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

local status_ok, loaded_module = pcall(require, "user.init")
if status_ok then
	antbase = loaded_module
else
	vim.notify("No user_config found!")
end

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		antbase.plugins
	}
}, {})
