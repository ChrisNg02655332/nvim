local utils = require "core.utils"

vim.keymap.set('n', '<leader>n', "<cmd> enew <CR>", { desc = 'New buffer' })
vim.keymap.set('n', '<tab>', "<cmd> bnex <CR>", { desc = 'Next buffer' })
vim.keymap.set('n', '<S-tab>', "<cmd> bprevious <CR>", { desc = 'Prev buffer' })
vim.keymap.set('n', '<C-s>', "<cmd> w <CR>", { desc = 'Save buffer' })
vim.keymap.set('n', '<leader>c', function() require("bufdelete").bufdelete(0, false) end, { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>C', "<cmd> xa <CR>", { desc = 'Force close buffer' })

-- Lazy git
vim.keymap.set('n', '<leader>gg', function() utils.toggle_term_cmd("lazygit") end, { desc = 'ToggleTerm lazygit' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
