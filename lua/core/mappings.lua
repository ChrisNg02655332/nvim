local M = {}

M.general = {
	n = {
		-- Remap for dealing with word wrap
		["k"] = { "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
		["j"] = { "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

		["<leader>n"] = { "<cmd> enew <cr>", { desc = "New Buffer" } },

		["<tab>"] = { "<cmd> bnex <cr>", { desc = "Next Buffer" } },
		["<S-tab>"] = { "<cmd> bprevious <cr>", { desc = "Prev Buffer" } },
		["<C-s>"] = { "<cmd> up <cr>", { desc = "Save Buffer" } },

		["K"] = { "<cmd> move -2 <cr>", { desc = "Move line up" } },
		["J"] = { "<cmd> move +1 <cr>", { desc = "Move line down" } },

		["<C-a>"] = { "ggVG", { desc = "Select all" } }
	}
}

M.bdelete = {
	n = {
		["<leader>x"] = { function() require("bufdelete").bufdelete(0, false) end, { desc = "Close Buffer" } }
	}
}

M.lspconfig = {
	n = {
		["<leader>ca"] = { vim.lsp.buf.code_action, { desc = "Hover code actions" } }
	}
}

M.telescope = {
	n = {
		["<leader>sb"] = { require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" } },
		["<leader><space>"] = { function()
			require('telescope.builtin').buffers({
				-- entry_maker = require("core.utils.telescope").gen_from_buffer(),
			})
		end, { desc = '[ ] Find existing buffers' } },

		["<leader>gf"] = { require("telescope.builtin").git_files, { desc = "Search Git Files" } },
		["<leader>sf"] = { require("telescope.builtin").find_files, { desc = "Search Files" } },
		["<leader>sh"] = { require("telescope.builtin").help_tags, { desc = "Search Help" } },
		["<leader>sw"] = { require("telescope.builtin").grep_string, { desc = "Search current Word" } },
		["<leader>sd"] = { require("telescope.builtin").diagnostics, { desc = "Search Diagnostics" } },
		["<leader>sc"] = { "<cmd> Cheatsheet <cr>", { desc = "Search Cheatsheet" } },
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
