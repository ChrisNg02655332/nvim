return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { 'node_modules', 'deps', '_build' },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = 'Telescope: ' .. desc })
      end

      map('<leader>sb', '<cmd>Telescope oldfiles<cr>', '[?] Find recently opened files')
      map('<leader><space>', '<cmd>Telescope buffers<cr>', '[ ] Find existing buffers')
      map('<leader>gf', '<cmd>Telescope git_files<cr>', '[S]earch [G]it [F]iles')
      map('<leader>sf', '<cmd>Telescope find_files<cr>', '[S]earch [F]iles')
      map('<leader>sg', '<cmd>Telescope live_grep<cr>', '[S]earch [G]rev')
      map('<leader>sw', '<cmd>Telescope grep_string<cr>', '[S]earch [C]urrent [W]ord')
      map('<leader>sd', '<cmd>Telescope diagnostics<cr>', '[S]earch [D]iagnostics')
      map('<leader>sc', '<cmd> Cheatsheet <cr>', '[S]earch [C]heatsheet')

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
  },
}
