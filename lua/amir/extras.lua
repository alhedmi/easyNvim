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
  require("alpha").setup(require("alpha.themes.startify").config)
end

-- Surround editing
if config.enable_surround then
  require("nvim-surround").setup({})
end

-- Auto-pairs for brackets and quotes
if config.enable_autopairs then
  require("nvim-autopairs").setup({})
end
