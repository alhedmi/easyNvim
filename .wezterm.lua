-- .wezterm.lua




local wezterm = require 'wezterm'

return {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font_with_fallback({
    "JetBrainsMono Nerd Font",
  }),
  font_size = 12.5,
  
    background = {
      {
        source = {
          File = "C:/Users/ameer/AppData/Local/nvim/background.jpg",
        },
        hsb = {
          brightness = 0.1,
          hue = 1.0,
          saturation = 1.0,
        },
        opacity = 0.6,
        attachment = "Fixed",
        
      },
    },
  -- Transparency
  window_background_opacity = 0.9,
  text_background_opacity = 1.0,

  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },

  window_decorations = "TITLE | RESIZE",
  scrollback_lines = 5000,
  front_end = "OpenGL",
}

