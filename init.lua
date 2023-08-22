for _, source in ipairs({
  "core.bootstrap",
  "core.mappings",
  "core.options",
  "core.lazy",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end

  if source == "core.mappings" then
    require "core.utils".load_mappings("general")
  end
end

if livevim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, livevim.default_colorscheme) then
    require("core.utils").notify(("Error setting up colorscheme: `%s`"):format(livevim.default_colorscheme))
  end
end
