local wezterm = require 'wezterm'
local config = {}

config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' },
    { family = 'Terminus', weight = 'Bold' },
    'Noto Color Emoji',
}
config.warn_about_missing_glyphs = false
config.font_size = 14
config.color_scheme = 'DoomOne'
config.enable_tab_bar = false
return config
