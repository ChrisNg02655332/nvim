return {
	ensure_installed = { "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim", "vimdoc" },
	auto_install = true,
	highlight = {
		enable = true,
		use_languagetree = true,
		additional_vim_regex_highlighting = { "ruby" },
	},
	indent = { enable = true, disable = { "ruby" } },
}
