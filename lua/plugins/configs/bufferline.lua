return {
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text = function()
          return vim.fn.getcwd()
        end,
        highlight = "Directory",
        text_align = "left",
        separator = true,
      }
    },
  }
}
