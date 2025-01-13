local treesitter = require("nvconfig").treesitter

return {
	ensure_installed = treesitter.ensure_install,
	auto_install = true,
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
}
