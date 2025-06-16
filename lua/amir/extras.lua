-- lua/amir/extras.lua
local config = require("amir.config")

-- ToggleTerm (terminal integration)
if config.enable_terminal then
  require("toggleterm").setup({
    direction = "float",
    open_mapping = [[<c-\>]],
  })
end

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
    dashboard.button("t", "  File Tree", ":NvimTreeToggle<CR>"),
    dashboard.button("q", "󰗼  Quit", ":qa<CR>"),
  }

  dashboard.section.footer.val = {
    "🔥 easyNvim loaded. Ready to roll.",
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


-- Close dashboard tab after file is opened from it
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    local alpha_tab = vim.api.nvim_get_current_tabpage()

    vim.api.nvim_create_autocmd("BufReadPost", {
      once = true,
      callback = function()
        local current_tab = vim.api.nvim_get_current_tabpage()
        if current_tab ~= alpha_tab then
          vim.cmd("tabclose " .. alpha_tab)
        end
      end,
    })
  end,
})


-- Extra HELP!!!!

vim.api.nvim_create_user_command("EasyNvimHelp", function()
  vim.cmd("vsplit ~/.config/nvim/README.md")
  vim.cmd("set filetype=markdown")  
end, {})


-- Surround editing
if config.enable_surround then
  require("nvim-surround").setup({})
end

-- Auto-pairs for brackets and quotes
if config.enable_autopairs then
  require("nvim-autopairs").setup({})
end
