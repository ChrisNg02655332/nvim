local M = {}

M.ui = {
  colorscheme = function()
    require("catppuccin").load()
  end,

  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },
}

M.plugins = {}

M.lazy_vim = require "plugins.configs.lazy"

M.mappings = require "core.mappings"

return M
