return {
	lsp = {
		elixirls = {},
		svelte = {},
		rust_analyzer = {},
		jsonls = {},
		ts_ls = {},
		prettierd = {},
		solidity_ls_nomicfoundation = {},
		cssls = {
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		},
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		},
	},
}
