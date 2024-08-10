local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' },
}
config.warn_about_missing_glyphs = true
config.font_size = 14
config.color_scheme = 'tokyonight-storm'
config.enable_tab_bar = false
return config
