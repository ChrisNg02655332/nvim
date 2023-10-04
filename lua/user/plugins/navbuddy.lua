return {
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim"
    },
    opts = { lsp = { auto_attach = true } },
    keys = {
      { "<leader>dd", "<cmd> Navbuddy <CR>", { desc = "Popup Display Breadcrumbs" } }
    },
  }
}
