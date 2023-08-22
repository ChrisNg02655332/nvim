local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
