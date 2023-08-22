local M = {}

M.extend_tbl = function(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

M.notify = function(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, M.extend_tbl({ title = "LiveVim" }, opts))
  end)
end

M.load_mappings = function(module)
  maps = require "core.mappings"[module] or {}

  for mode, mode_values in pairs(livevim.user_opts("mappings", maps)) do
    for keybind, mapping_info in pairs(mode_values) do
      vim.keymap.set(mode, keybind, mapping_info[1], { desc = mapping_info[2] })
    end
  end
end

M.get_icon = function(kind, padding)
  local icon = require("core.icons")[kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

      -- dont defer for treesitter as it will show slow highlighting
      -- This deferring only happens only when we do "nvim filename"
      if plugin ~= "nvim-treesitter" then
        vim.schedule(function()
          require("lazy").load({ plugins = plugin })

          if plugin == "nvim-lspconfig" then
            vim.cmd("silent! do FileType")
          end
        end, 0)
      else
        require("lazy").load({ plugins = plugin })
      end
    end,
  })
end


return M
