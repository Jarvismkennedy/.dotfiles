local wezterm = require 'wezterm'
local config = {}
config.keys = {}
for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|ALT',
        action = wezterm.action.ActivateTab(i - 1),
    })
end
table.insert(config.keys, {
    key = 'q',
    mods = 'CTRL|ALT',
    action = wezterm.action.CloseCurrentTab {confirm = true},
})
table.insert(config.keys, {
    key = 't',
    mods = 'CTRL|ALT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
})

config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' },
}
config.warn_about_missing_glyphs = true
config.font_size = 12
-- config.color_scheme = 'rose-pine-moon'
--
config.color_scheme = 'Catppuccin Mocha'
config.force_reverse_video_cursor = true
config.use_fancy_tab_bar = false
-- config.color_scheme = 'OneDark (base16)'
config.enable_tab_bar = true
-- config.tab_bar_at_bottom = true

local function segments_for_right_status(window)
    return {
        window:active_workspace(),
        wezterm.strftime '%a %b %-d %H:%M',
        wezterm.hostname(),
    }
end

wezterm.on('update-status', function(window, _)
    local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
    local segments = segments_for_right_status(window)

    local color_scheme = window:effective_config().resolved_palette
    -- Note the use of wezterm.color.parse here, this returns
    -- a Color object, which comes with functionality for lightening
    -- or darkening the colour (amongst other things).
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    -- Each powerline segment is going to be coloured progressively
    -- darker/lighter depending on whether we're on a dark/light colour
    -- scheme. Let's establish the "from" and "to" bounds of our gradient.
    local gradient_to = bg
    local gradient_from = gradient_to:lighten(0.2)

    -- Yes, WezTerm supports creating gradients, because why not?! Although
    -- they'd usually be used for setting high fidelity gradients on your terminal's
    -- background, we'll use them here to give us a sample of the powerline segment
    -- colours we need.
    local gradient = wezterm.color.gradient(
        {
            orientation = 'Horizontal',
            colors = { gradient_from, gradient_to },
        },
        #segments -- only gives us as many colours as we have segments.
    )

    -- We'll build up the elements to send to wezterm.format in this table.
    local elements = {}

    for i, seg in ipairs(segments) do
        local is_first = i == 1

        if is_first then
            table.insert(elements, { Background = { Color = 'none' } })
        end
        table.insert(elements, { Foreground = { Color = gradient[i] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })

        table.insert(elements, { Foreground = { Color = fg } })
        table.insert(elements, { Background = { Color = gradient[i] } })
        table.insert(elements, { Text = ' ' .. seg .. ' ' })
    end

    window:set_right_status(wezterm.format(elements))
end)
return config
