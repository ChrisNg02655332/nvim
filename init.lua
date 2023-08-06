-- require("core.bootstrap")
require("core.utils").load_mappings()
-- require("core.options")
-- require("core.lazy")

for _, source in ipairs({
  "core.bootstrap",
  "core.options",
  "core.lazy",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
  end
end

if livevim.default_colorscheme then
  if not pcall(vim.cmd.colorscheme, livevim.default_colorscheme) then
    require("core.utils").echo(("Error setting up colorscheme: `%s`"):format(livevim.default_colorscheme))
  end
end

-- print(vim.fn.expand("%"))
