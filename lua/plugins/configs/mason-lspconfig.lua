local utils = require("core.utils")

local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	utils.load_mappings("lsp", { buffer = bufnr })
end

M.setup = function()
	local opts = {
		ensure_installed = {
			"lua_ls",
			"html",
			"jsonls",
			"graphql",
			"tsserver",
			"tailwindcss",
			"elixirls",
			"eslint",
		},
	}

	local lspconfig = require("lspconfig")
	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	require("mason").setup()
	require("mason-lspconfig").setup(opts)
	require("mason-lspconfig").setup_handlers({
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = lsp_capabilities,
			})
		end,

		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
					},
				},
			})
		end,

		["tsserver"] = function()
			require("typescript").setup({ server = opts })
		end,

		["eslint"] = function()
			lspconfig.eslint.setup({
				on_attach = function(_, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
		end,
	})
end

return M
