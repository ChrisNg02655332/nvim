local M = {}

M.general = {
  n = {
    -- Remap for dealing with word wrap
    ['k'] = { "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
    ['j'] = { "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },

    ['<leader>n'] = { '<cmd> enew <cr>', { desc = 'New Buffer' } },

    ['<tab>'] = { '<cmd> bnex <cr>', { desc = 'Next Buffer' } },
    ['<S-tab>'] = { '<cmd> bprevious <cr>', { desc = 'Prev Buffer' } },
    ['<C-s>'] = { '<cmd> up <cr>', { desc = 'Save Buffer' } },

    ['<leader>q'] = { '<cmd> q <cr>', { desc = 'Quit without save' } },
    ['<leader>Q'] = { '<cmd> q! <cr>', { desc = 'Force quit without save' } },

    ['K'] = { '<cmd> move -2 <cr>', { desc = 'Move line up' } },
    ['J'] = { '<cmd> move +1 <cr>', { desc = 'Move line down' } },

    ['<C-a>'] = { 'ggVG', { desc = 'Select all' } },
    ['<PageUp>'] = { '^', { desc = 'Move the cursor to the first non-blank character of a line' } },

    ['D'] = { vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },
  },

  i = {
    ['<PageUp>'] = { '<Esc>^ | I', { desc = 'Move the cursor to the first non-blank character of a line' } },
  },
}

M.bdelete = {
  n = {
    ['<leader>x'] = {
      function()
        require('bufdelete').bufdelete(0, false)
      end,
      { desc = 'Close Buffer' },
    },
  },
}

M.comment = {
  n = {
    ['<leader>/'] = {
      function()
        require('Comment.api').toggle.linewise.current()
      end,
      { desc = 'Toggle Comment' },
    },
  },

  v = {
    ['<leader>/'] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      { desc = 'Toggle Comment' },
    },
  },
}

M.lspconfig = {
  n = {
    ['<leader>ca'] = { vim.lsp.buf.code_action, { desc = 'Hover code actions' } },
    ['<leader>ds'] = { require('telescope.builtin').lsp_document_symbols, { desc = 'Document Symbol' } },
  },
}

M.gitsigns = {
  n = {
    ['<leader>gb'] = { '<cmd> Gitsigns blame_line<cr>', { desc = 'Blame line' } },
    ['<leader>gh'] = { '<cmd> Gitsigns preview_hunk <cr>', { desc = 'Preview hunk' } },
  },
}

M.neotree = {
  n = {
    ['<leader>e'] = { '<cmd> Neotree toggle <cr>', { desc = 'Toggle Explorer' } },
    ['<leader>o'] = {
      function()
        if vim.bo.filetype == 'neo-tree' then
          vim.cmd.wincmd 'p'
        else
          vim.cmd.Neotree 'focus'
        end
      end,
      { desc = 'Toggle Explorer' },
    },
  },
}

M.telescope = {
  n = {
    ['<leader>sb'] = { require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' } },
    ['<leader><space>'] = {
      function()
        require('telescope.builtin').buffers {
          -- entry_maker = require("core.utils.telescope").gen_from_buffer(),
        }
      end,
      { desc = '[ ] Find existing buffers' },
    },

    ['<leader>gf'] = { require('telescope.builtin').git_files, { desc = 'Search Git Files' } },
    ['<leader>sf'] = { require('telescope.builtin').find_files, { desc = 'Search Files' } },
    ['<leader>sg'] = { require('telescope.builtin').live_grep, { desc = 'Search Grev' } },
    ['<leader>sh'] = { require('telescope.builtin').help_tags, { desc = 'Search Help' } },
    ['<leader>sw'] = { require('telescope.builtin').grep_string, { desc = 'Search current Word' } },
    ['<leader>sd'] = { require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' } },
    ['<leader>sc'] = { '<cmd> Cheatsheet <cr>', { desc = 'Search Cheatsheet' } },
  },
}

M.toggleterm = {
  n = {
    ['<leader>gg'] = {
      function()
        require('core.utils').toggle_term_cmd 'lazygit'
      end,
      { desc = 'ToggleTerm LazyGit' },
    },
    ['<C-/>'] = { '<cmd> ToggleTerm direction=float <cr>', { desc = 'ToggleTerm float' } },
  },
}

return M
