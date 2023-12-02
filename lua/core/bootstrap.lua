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

-- local M = {}
--
-- M.load_module = function()
-- 	local config_path = vim.fn.stdpath "config"
-- 	local found_file = nil
--
-- 	local module = "user.init"
-- 	-- convert the module path to a file path (example user.init -> user/init.lua)
-- 	local module_path = config_path .. "/lua/" .. module:gsub("%.", "/") .. ".lua"
-- 	-- check if there is a readable file, if so, set it as found
-- 	if vim.fn.filereadable(module_path) == 1 then found_file = module_path end
--
-- 	if found_file then
-- 		-- try to load the file
-- 		local status_ok, loaded_module = pcall(require, module)
--
-- 		-- if successful at loading, set the return variable
-- 		if status_ok then
-- 			out = loaded_module
-- 			-- if unsuccessful, throw an error
-- 		else
-- 			vim.api.nvim_err_writeln("Error loading file: " .. found_file .. "\n\n" .. loaded_module)
-- 		end
-- 	end
-- end
--

-- local lazy_opts = {
--	defaults = { lazy = true },
--}

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "users.plugins" }
	}
}, {})
