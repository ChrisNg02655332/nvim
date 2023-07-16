local M = {}

M.ui = {
  theme = "nightfox"
}

M.lazy_nvim = require "plugins.configs.lazy_nvim"

M.mappings = require "core.mappings"

return M
