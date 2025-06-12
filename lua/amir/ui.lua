-- lua/amir/ui.lua
local config = require("amir.config")



-- Apply the colorscheme
vim.cmd.colorscheme(config.theme)

-- Enable true color
vim.opt.termguicolors = true

-- Setup lualine
require("lualine").setup({
  options = {
    theme = config.theme,
    section_separators = "",
    component_separators = "",
  },
})

-- Optional UI plugins
if config.enable_indent_guides then
  require("ibl").setup()
end

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
