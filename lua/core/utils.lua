local M = {}

M.load_mappings = function(module)
  local maps = require "core.mappings"[module] or {}

  for mode, mode_values in pairs(maps) do
    for keybind, mapping_info in pairs(mode_values) do
      vim.keymap.set(mode, keybind, mapping_info[1], { desc = mapping_info[2] })
    end
  end
end

M.get_icon = function(kind, padding)
  local icon = require("core.icons")[kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

-- This func support lazy git
M.toggle_term_cmd = function(opts)
  local terms = {}
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == "string" then
    opts = { cmd = opts, hidden = true }
  end
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then
    terms[opts.cmd] = {}
  end
  if not terms[opts.cmd][num] then
    if not opts.count then
      opts.count = vim.tbl_count(terms) * 100 + num
    end
    if not opts.on_exit then
      opts.on_exit = function()
        terms[opts.cmd][num] = nil
      end
    end
    terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end


return M
