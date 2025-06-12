-- lua/amir/ui.lua
local config = require("amir.config")

-- Set theme
vim.cmd.colorscheme(config.theme)

-- Enable true color support
vim.opt.termguicolors = true

-- Setup lualine (status line)
require("lualine").setup({
  options = {
    theme = config.theme,
    section_separators = "",
    component_separators = "",
  }
})

-- Indentation guides (if enabled)
if config.enable_indent_guides then
  require("ibl").setup()
end

-- Fancy UI: noice + notify (if enabled)
if config.use_fancy_ui then
  require("notify").setup({})
  vim.notify = require("notify")

  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  })
end
