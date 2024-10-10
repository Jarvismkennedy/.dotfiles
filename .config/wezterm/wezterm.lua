local wezterm = require 'wezterm'
function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read '*a')
    f:close()
    if raw then
        return s
    end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
end
local home = os.getenv 'HOME'
local fd = '/usr/bin/fd'
local work = home .. '/work'
local personal = home .. '/personal'
local dots = home .. '/.dotfiles'

local toggle = function(window, pane)
    local projects = {}

    local success, stdout, stderr = wezterm.run_child_process {
        fd,
        '-HI',
        '-td',
        '^.git$',
        '--max-depth=4',
        work,
        personal,
        dots,
    }

    if not success then
        wezterm.log_error('Failed to run fd: ' .. stderr)
        return
    end

    for line in stdout:gmatch '([^\n]*)\n?' do
        local project = line:gsub('/.git/$', '')
        local label = project
        local id = project:gsub('.*/', '')
        table.insert(projects, { label = tostring(label), id = tostring(id) })
    end

    window:perform_action(
        wezterm.action.InputSelector {
            action = wezterm.action_callback(function(win, _, id, label)
                if not id and not label then
                    wezterm.log_info 'Cancelled'
                else
                    wezterm.log_info('Selected ' .. label)
                    win:perform_action(wezterm.action.SwitchToWorkspace { name = id, spawn = { cwd = label } }, pane)
                end
            end),
            fuzzy = true,
            title = 'Select project',
            choices = projects,
        },
        pane
    )
end

local is_macos = os.capture 'uname' == 'Darwin'
local config = {}
config.use_ime = false
config.debug_key_events = true
config.keys = {}

for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|META',
        action = wezterm.action.ActivateTab(i - 1),
    })
end
table.insert(config.keys, { key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay })
table.insert(config.keys, {
    key = 'q',
    mods = 'CTRL|META',
    action = wezterm.action.CloseCurrentTab { confirm = true },
})
table.insert(config.keys, {
    key = 't',
    mods = 'CTRL|META',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
})
table.insert(config.keys, {
    key = 'f',
    mods = 'CTRL|META',
    action = wezterm.action_callback(toggle),
})
table.insert(config.keys, {
    key = 's',
    mods = 'CTRL|META',
    action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
})

config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', weight = 'Medium' },
}
config.warn_about_missing_glyphs = true
local font_size = 12
if is_macos then
    font_size = 14
end
config.font_size = font_size
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
