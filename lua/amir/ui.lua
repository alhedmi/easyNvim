-- lua/amir/ui.lua
local config = require("amir.config")

local extras = require("amir.extras")


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



-- Alpha (startup dashboard)

if config.enable_dashboard then
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")


dashboard.section.header.val = {
  [[             █████╗ ███╗   ███╗██╗██████╗ ███████╗                ]],
  [[            ██╔══██╗████╗ ████║██║██╔══██╗██╔════╝                ]],
  [[            ███████║██╔████╔██║██║██████╔╝███████╗                ]],
  [[            ██╔══██║██║╚██╔╝██║██║██╔══██╗╚════██║                ]],
  [[            ██║  ██║██║ ╚═╝ ██║██║██║  ██║███████║                ]],
  [[            ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚══════╝                ]],
  [[                                                                  ]],
  [[███████╗ █████╗ ███████╗██╗   ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗]],
  [[██╔════╝██╔══██╗██╔════╝╚██╗ ██╔╝████╗  ██║██║   ██║██║████╗ ████║]],
  [[█████╗  ███████║███████╗ ╚████╔╝ ██╔██╗ ██║██║   ██║██║██╔████╔██║]],
  [[██╔══╝  ██╔══██║╚════██║  ╚██╔╝  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
  [[███████╗██║  ██║███████║   ██║   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║]],
  [[╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
  [[                                                                  ]],  

  [[                                                                  ]],  
  [[                                                                  ]], 
  [[                                                                  ]], 
  [[                                                                  ]],
  [[                                                                  ]],  
  [[                                                                  ]], 
  [[                                                                  ]] 

}
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
    dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "󰁯  Restore Session", ":SessionRestore<CR>"),
    dashboard.button("t", "  File Tree", ":NvimTreeToggle<CR>"),
    dashboard.button("q", "󰗼  Quit", ":qa<CR>"),
  }

  dashboard.section.footer.val = {
    "",
    "💡 Did you know? ",
    extras.tips_README(),
  }
dashboard.section.footer.opts = {
  position = "center",
}
  dashboard.opts.layout = {
    { type = "padding", val = 5 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 2 },
    dashboard.section.footer,
  }

  alpha.setup(dashboard.opts)
end



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
