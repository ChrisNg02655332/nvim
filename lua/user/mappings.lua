vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true })
return {
  -- first key is the mode
  n = {
    ["<S-Tab>"] = { ":bprev<CR>", desc = "Prev buffer"},
    ["<S-Tab>"] = { ":bnext<CR>", desc = "Next buffer"}
  }
}
