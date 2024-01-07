local M = {}

M.general = {
	n = {
		-- Remap for dealing with word wrap
		["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
		["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },


		["<leader>n"] = { "<cmd> enew <cr>", { desc = "New Buffer" } },

		["<tab>"] = { "<cmd> bnex <cr>", { desc = "Next Buffer" } },
		["<S-tab>"] = { "<cmd> bprevious <cr>", { desc = "Prev Buffer" } },

		["<C-s>"] = { "<cmd> w <cr>", { desc = "Save Buffer" } },

		["K"] = { "<cmd> move -2 <cr>", { desc = "Move line up" } },
		["J"] = { "<cmd> move +1 <cr>", { desc = "Move line down" } },

		["<C-h>"] = { "<C-w>h", { desc = "Window left" } },
		["<C-l>"] = { "<C-w>l", { desc = "Window right" } },
		["<C-j>"] = { "<C-w>j", { desc = "Window down" } },
		["<C-k>"] = { "<C-w>k", { desc = "Window up" } },

		["<S-ScrollWheelUp>"] = { "zH", { desc = "" } },
		["<S-ScrollWheelDown>"] = { "zL", { desc = "" } }

	},
}

M.bdelete = {
	n = {
		["<leader>c"] = { function() require("bufdelete").bufdelete(0, false) end, { desc = "Close Buffer" } }
	}
}

M.comment = {
	n = {
		["<leader>/"] = {
			function() require('Comment.api').toggle.linewise.current() end,
			{ desc = 'Toggle Comment' } },
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = 'Toggle Comment' }
		}
	}
}

M.gitsigns = {
	n = {
		["<leader>gb"] = { "<cmd> Gitsigns blame_line<cr>", { desc = "Blame line" } },
		["<leader>gh"] = { "<cmd> Gitsigns preview_hunk <cr>", { desc = "Preview hunk" } },
	}
}

M.lspconfig = {
	n = {
		["gd"] = { vim.lsp.buf.definition, { desc = "Goto Definition" } },
		["gr"] = { function() require('telescope.builtin').lsp_references() end, { desc = "Goto References" } },
		["gI"] = { vim.lsp.buf.implementation, desc = "Goto Implementation" },
		["<leader>D"] = { vim.lsp.buf.type_definition, { desc = "Type Definition" } },
		["<leader>ds"] = { function() require('telescope.builtin').lsp_document_symbols() end, { desc = "Document Symbols" } },
		["<leader>ws"] = { function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, { desc = "Workspace Symbols" } },
		["<leader>ld"] = { vim.lsp.buf.hover, { desc = "Hover Documentation" } },
		["[d"] = { vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" } },
		["]d"] = { vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" } },
	}
}

M.neotree = {
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

M.toggleterm = {
	n = {
		["<leader>gg"] = {
			function()
				require("core.utils").toggle_term_cmd("lazygit")
			end, { desc = "ToggleTerm LazyGit" }
		}
	}
}

return M
