return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'famiu/bufdelete.nvim',
    keys = {
      { '<leader>x', "<cmd>lua  require('bufdelete').bufdelete(0, false) <cr>", desc = 'Bdelete: Close Buffer' },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '┊' },
      scope = { highlight = { 'Normal' } },
    },
  },

  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh yarn',
    config = true,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = { 'toggleterm' },
      },
      sections = {
        lualine_c = {
          {
            'filename',
            cond = function()
              return vim.bo.filetype ~= 'neo-tree'
            end,
          },
        },
        lualine_x = {
          {
            'fileformat',
            symbols = {
              unix = vim.fn.has 'macunix' == 1 and '' or '', -- e712
              dos = '', -- e70f
              mac = '', -- e711
            },
          },
        },
      },
    },
  },

  -- http request
  {
    'mistweaverco/kulala.nvim',
    otps = {},
  },
}
