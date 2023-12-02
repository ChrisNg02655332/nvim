-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

require('telescope').setup {
	defaults = {
		file_ignore_patterns = { "node_modules", "dist", "build", "deps", "_build" },
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'software-licenses')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function()
	require('telescope.builtin').buffers({
		-- entry_maker = require("core.utils.telescope").gen_from_buffer(),
	})
end, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sc', '<cmd> Cheatsheet <cr>', { desc = "Search Cheatsheet" })
