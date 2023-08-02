local config = {
  options = {
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1,       -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { "filetype" },
  },
}

return config
