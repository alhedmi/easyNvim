-- lua/amir/config.lua
-- Global config flags for easyNvim

local M = {}


M.theme = "catppuccin-mocha"   -- Options: "tokyonight", "gruvbox", "catppuccin" catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
M.use_fancy_ui = true     -- Enable lspsaga, noice.nvim, etc.

-- Extras (toggle plugins)
M.enable_terminal = true
M.enable_dashboard = true
M.enable_surround = true
M.enable_autopairs = true
M.enable_signature_help = true
M.enable_lspsaga = false
M.enable_which_key = true
M.enable_file_tree = true
M.enable_indent_guides = true

return M
