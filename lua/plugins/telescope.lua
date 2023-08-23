return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings("telescope")
    end,
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local sorters = require("telescope.sorters")

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

        extensions = {
          file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
          },
        },
      }

      telescope.setup(opts)
    end,
  },
}
