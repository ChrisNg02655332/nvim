return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      position = 'right',
    },
    keys = {
      { '<leader>st', '<cmd> Trouble <cr>', desc = 'Trouble: Search Trouble' },
    },
  },
}
