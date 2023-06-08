local api = vim.api
local config = require "core.default_config"

local M = {}

M.lazy = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    require("core.utils").notify "Bootstrapping lazy.nvim .."
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", 
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require "plugins" 

  require("lazy.core.util").try(function()
    if type(config.ui.colorscheme) == "function" then
      config.ui.colorscheme() 
    else
      vim.cmd.colorscheme(config.ui.colorscheme)
    end
  end, {
    msg = "Could not load your colorscheme",
    on_error = function(msg)
      require("lazy.core.util").error(msg)
      vim.cmd.colorscheme("habamax")
    end,
  })
end

return M
