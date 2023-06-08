local default_plugins = {
  "nvim-lua/plenary.nvim",
  "catppuccin/nvim",
}

local config = require("core.utils").load_config()
require("lazy").setup(default_plugins, config.lazy_vim)
