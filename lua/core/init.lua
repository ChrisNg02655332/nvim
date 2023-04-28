local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------
opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.cmd [[set confirm]]

-------------------------------------- autocmds ------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end


-- dont list quickfix buffers
autocmd("FileType", {
  group = augroup("quickfix"),
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd({"BufEnter", "FileReadPost"}, { 
  group = augroup("fold"),
  pattern = "*", 
  command = "normal zR" 
})

autocmd("BufWritePre", {
  group = augroup('format_on_save'),
  pattern = "*.ex,*.exs,*.heex",
  command = "lua vim.lsp.buf.format()"
})

