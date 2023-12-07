local M = {}

M.General = {
	n = {
		-- See `:help vim.keymap.set()`
		["<Space>"] = { "<Nop>", { silent = true } },

		-- Remap for dealing with word wrap
		["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
		["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },


		["<leader>n"] = { "<cmd> enew <cr>", { desc = "New Buffer" } },

		["<tab>"] = { "<cmd> bnex <cr>", { desc = "Next Buffer" } },
		["<S-tab>"] = { "<cmd> bprevious <cr>", { desc = "Prev Buffer" } },

		["<C-s>"] = { "<cmd> w <cr>", { desc = "Save Buffer" } },

		["<C-k>"] = { "<cmd> move -2 <cr>", { desc = "Move line up" } },
		["<C-j>"] = { "<cmd> move +1 <cr>", { desc = "Move line down" } },

	},

	v = {
		-- See `:help vim.keymap.set()`
		["<Space>"] = { "<Nop>", { silent = true } },
	},
}

M.BDelete = {
	n = {
		["<leader>c"] = { function() require("bufdelete").bufdelete(0, false) end, { desc = "Close Buffer" } }
	}
}

M.Comment = {
	n = {
		["<leader>/"] = {
			function() require('Comment.api').toggle.linewise.current() end,
			{ desc = 'Toggle Comment' } },
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Toggle Comment' }
		}
	}
}

M.Lsp = {
	n = {
		["gd"] = { vim.lsp.buf.definition, { desc = "Goto Definition" } },
		["gr"] = { function() require('telescope.builtin').lsp_references() end, { desc = "Goto References" } },
		["gI"] = { vim.lsp.buf.implementation, desc = "Goto Implementation" },
		["<leader>D"] = { vim.lsp.buf.type_definition, { desc = "Type Definition" } },
		["<leader>ds"] = { function() require('telescope.builtin').lsp_document_symbols() end, { desc = "Document Symbols" } },
		["<leader>ws"] = { function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, { desc = "Workspace Symbols" } },
		["K"] = { vim.lsp.buf.hover, { desc = "Hover Documentation" } },
		["[d"] = { vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" } },
		["]d"] = { vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" } },
	}
}

M.Neotree = {
	n = {
		["<leader>e"] = { "<cmd> Neotree toggle <cr>", { desc = 'Toggle Explorer' } },
		["<leader>o"] = {
			function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd("p")
				else
					vim.cmd.Neotree("focus")
				end
			end,
			{ desc = "Toggle Explorer" } }
	}
}

M.Term = {
	n = {
		["<leader>gg"] = {
			function()
				require("core.utils").toggle_term_cmd("lazygit")
			end, { desc = "ToggleTerm LazyGit" }
		}
	}
}

return M
