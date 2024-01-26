local utils = require("core.utils")
utils.load_mappings("lspconfig")


-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

local default_servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

local servers = utils.extend_tbl(default_servers, antbase.lspconfig.servers)

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local lspconfig = require 'lspconfig'
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

local default_handler = {
	function(server_name)
		lspconfig[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end
}

local handlers = utils.extend_tbl(default_handler, antbase.lspconfig.setup_handlers)

mason_lspconfig.setup_handlers(handlers)

-- Whenever an LSP attaches to a buffer, we will run this function.
local augroups = {}
local get_augroup = function(client)
	if not augroups[client.id] then
		local group_name = 'antbase-lsp-format-' .. client.name
		local id = vim.api.nvim_create_augroup(group_name, { clear = true })
		augroups[client.id] = id
	end

	return augroups[client.id]
end

-- See `:help LspAttach` for more information about this autocmd event.
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('antbase-lsp-attach-format', { clear = true }),
	-- This is where we attach the autoformatting for reasonable clients
	callback = function(args)
		local client_id = args.data.client_id
		local client = vim.lsp.get_client_by_id(client_id)
		local bufnr = args.buf

		-- Only attach to clients that support document formatting
		if not client.server_capabilities.documentFormattingProvider then
			return
		end

		if type(antbase.lspconfig.formatting.filter) == "function" then
			if antbase.lspconfig.formatting.filter(client, bufnr) == true then
				return
			end
		end

		-- Create an autocmd that will run *before* we save the buffer.
		--  Run the formatting command for the LSP that has just attached.
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = get_augroup(client),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format {
					async = false,
					filter = function(c)
						return c.id == client.id
					end,
				}
			end,
		})
	end,
})
