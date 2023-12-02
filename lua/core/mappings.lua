local M = {}

M.General = {
	n = {
		["<leader>n"] = { "<cmd> enew <cr>", { desc = "New Buffer" } },

		["<tab>"] = { "<cmd> bnex <cr>", { desc = "Next Buffer" } },
		["<S-tab>"] = { "<cmd> bprevious <cr>", { desc = "Prev Buffer" } },

		["<C-s>"] = { "<cmd> w <cr>", { desc = "Save Buffer" } },

		["<C-k>"] = { "<cmd> move -2 <cr>", { desc = "Move line up" } },
		["<C-j>"] = { "<cmd> move +1 <cr>", { desc = "Move line down" } },
	}
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
		['gd'] = { vim.lsp.buf.definition, { desc = 'Goto Definition' } }
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
