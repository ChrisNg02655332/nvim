local get_hex = require("cokeline/utils").get_hex

return {
  default_hl = {
    fg = get_hex("Normal", "fg"),
    bg = get_hex("Normal", "bg"),
  },
  sidebar = {
    filetype = "neo-tree",
    components = {
      {
        text = "",
        bg = get_hex("NeoTreeNormal", "bg"),
        style = "bold",
      },
    },
  },
  components = {
    {
      text = function(buffer) return (buffer.index ~= 1) and "▏" or "" end,
    },
    {
      text = "  ",
    },
    {
      text = function(buffer) return buffer.devicon.icon end,
      fg = function(buffer) return buffer.devicon.color end,
    },
    {
      text = " ",
    },
    {
      text = function(buffer) return buffer.filename .. "  " end,
      fg = function(buffer) return buffer.is_focused and "#61AFEF" or nil end,
      style = function(buffer) return buffer.is_focused and "bold" or nil end,
    },
    {
      text = "",
      on_click = function(idx, clicks, buttons, modifiers, buffer) buffer:delete() end,
    },
    {
      text = "  ",
    },
  },
}
