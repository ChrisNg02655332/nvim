local utils = require("core.utils")
local install_path = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(install_path) then
  utils.echo("  Installing lazy.nvim & plugins ...")

  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path })

  local oldcmdheight = vim.opt.cmdheight:get()
  vim.opt.cmdheight = 1

  vim.api.nvim_create_autocmd("User", {
    desc = "Load Mason and Treesitter after Lazy installs plugins",
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.opt.cmdheight = oldcmdheight
      vim.tbl_map(function(module)
        pcall(require, module)
      end, { "nvim-treesitter", "mason" })
      utils.echo("Mason is installing packages if configured, check status with `:Mason`")
    end,
  })
end

vim.opt.rtp:prepend(install_path)

local git_version = vim.fn.system({ "git", "--version" })
local major, min, _ = unpack(vim.tbl_map(tonumber, vim.split(git_version:match("%d+%.%d+%.%d"), "%.")))
local modern_git = major > 2 or (major == 2 and min >= 19)

local colorscheme = livevim.default_colorscheme and { livevim.default_colorscheme } or nil

local user_plugins = livevim.user_opts("plugins")
local spec = {}
vim.list_extend(spec, { { import = "plugins" }, user_plugins })

require("lazy").setup(livevim.user_opts("lazy", {
  spec = spec,
  defaults = { lazy = true },
  git = { filter = modern_git },
  install = { colorscheme = colorscheme },
  performance = {
    rtp = {
      paths = livevim.supported_configs,
      disabled_plugins = { "tohtml", "gzip", "zipPlugin", "netrwPlugin", "tarPlugin" },
    },
  },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
}))
