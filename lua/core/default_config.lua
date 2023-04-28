local M = {}

M.ui = {
  colorscheme = function()
    require("catppuccin").load()
  end,
}

M.plugins = {}

M.lazy_vim = require "plugins.configs.lazy"

M.mappings = require "core.mappings"

return M
