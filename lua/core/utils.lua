local M = {}

local user_mappings = {}

local status_ok, loaded_module = pcall(require, 'user.mappings')
if status_ok then
  user_mappings = loaded_module
else
  vim.notify 'No user mappings found!'
end

M.get_icon = function(kind, padding)
  local icon = require('core.icons')[kind]
  return icon and icon .. string.rep(' ', padding or 0) or ''
end

M.load_mappings = function(section)
  vim.schedule(function()
    local function set_section_map(section_values)
      for mode, mode_values in pairs(section_values) do
        for keybind, mapping_info in pairs(mode_values) do
          vim.keymap.set(mode, keybind, mapping_info[1], mapping_info[2])
        end
      end
    end

    local mappings = M.extend_tbl(require 'core.mappings', user_mappings)
    if mappings[section] then
      set_section_map(mappings[section])
    else
      vim.notify '[Error] Could not load mappings under user folder!'
    end
  end)
end

M.extend_tbl = function(default, opts)
  for k, v in pairs(opts) do
    if (type(v) == 'table') and (type(default[k] or false) == 'table') then
      M.extend_tbl(default[k], opts[k])
    else
      default[k] = v
    end
  end

  return default
end

-- This func support lazy git
M.toggle_term_cmd = function(opts)
  local terms = {}
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == 'string' then
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
    terms[opts.cmd][num] = require('toggleterm.terminal').Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end

M.close_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end

  if qf_exists == true then
    vim.cmd 'cclose'
    return
  end
end

return M
