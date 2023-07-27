local telescope = require "telescope"
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"

local opts = {
  defaults = {
    file_sorter = sorters.get_fuzzy_file,
    file_ignore_patterns = { "node_modules", "assets/vendor" },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      n = { ["q"] = actions.close },
    },
  },

  pickers = {
    colorscheme = {
      enable_preview = true,
      finder = finders.new_table { "onedark", "nightfox", "solarized8_flat" },
      --     -- on_cancel = function()
      --     --   local mytheme = require "plugins.mytheme"
      --     --   -- runs theme setup logic for M.chosen
      --     --   mytheme.setup()
      --     -- end,
      --     on_hover = function(colorscheme)
      --       -- local config = require "core.default_config"
      --       require("lazy.core.util").try(function() vim.cmd.colorscheme(colorscheme) end)
      --     end,
      on_change = function(colorscheme)
        require("lazy.core.util").try(function() vim.cmd.colorscheme(colorscheme) end)
      end,
    },
  },

  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
    },
  },
}

telescope.setup(opts)
