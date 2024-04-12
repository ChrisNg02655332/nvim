vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Enable lualine whole screen
vim.o.laststatus = 3

-- Enable fold
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- See `:help vim.keymap.set()`
-- vim.keymap.set({'n', 'i'}, '∆', rhs)
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('t', '<C-/>', '<C-\\><C-n><C-w>h', { silent = true })
vim.keymap.set('i', '<C-h>', '<left>', { noremap = true })
vim.keymap.set('i', '<C-j>', '<down>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<up>', { noremap = true })
vim.keymap.set('i', '<C-l>', '<right>', { noremap = true })

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', '<Esc>', require('core.utils').close_qf, { desc = 'Close qf' })
    vim.keymap.set('n', 'q', require('core.utils').close_qf, { desc = 'Close qf' })
  end,
})
