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
config.debug_key_events = false
config.keys = {
    { key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
    {
        key = 'q',
        mods = 'CTRL|META',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    {
        key = 't',
        mods = 'CTRL|META',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'f',
        mods = 'CTRL|META',
        action = wezterm.action_callback(toggle),
    },
    {
        key = 's',
        mods = 'CTRL|META',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    {
        key = 'd',
        mods = 'CTRL|META',
        action = wezterm.action.ScrollByPage(1),
    },
    {
        key = 'b',
        mods = 'CTRL|META',
        action = wezterm.action.ScrollByPage(-1),
    },
    {
        key = 'v',
        mods = 'CTRL|META',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'h',
        mods = 'CTRL|META',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'x',
        mods = 'CTRL|META',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },

}

for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|META',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

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

local function segments_for_right_status(window, mem, cpu)
    return {
        mem,
        cpu,
        window:active_workspace(),
        wezterm.strftime '%a %b %-d %H:%M',
        wezterm.hostname(),
    }
end

-- taken from github issue on sys info functionality request.
local memmb = { Total = 0, Available = 0 }
local cpuv = { total = 0, idle = 0, pct = 1 }
wezterm.on('update-status', function(window, _)
    local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

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

    -- memory info
    local _, mmout, _ = wezterm.run_child_process { 'head', '-n3', '/proc/meminfo' }
    local function update_memory_status(info, item)
        local numstr = info:match('Mem' .. item .. ':%s+(%S+)')
        memmb[item] = tonumber(numstr) / 1000
    end
    if memmb.Total == 0 then
        update_memory_status(mmout, 'Total')
    end
    update_memory_status(mmout, 'Available')
    local memstr = tostring(math.floor((memmb.Total - memmb.Available + 50) / 100) / 10)
    local memicons = '󰪞 󰪟 󰪠 󰪡 󰪢 󰪣 󰪤 󰪥 '
    local idx = math.ceil((1 - memmb.Available / memmb.Total) * 8)
    -- local memcolors = { '#02403a', '#00403a', '#01402a', '#01402a', '#311a00', '#40023a', '#401e00', '#400000' }
    memstr = memicons:sub(idx * 5 - 4, idx * 5) .. memstr .. 'G'
    -- cpu info
    local _, cpuout, _ = wezterm.run_child_process { 'head', '-n1', '/proc/stat' }
    local k, vtotal, vidle = 1, 0, 0
    for v in cpuout:gmatch '%d+' do
        vtotal = vtotal + tonumber(v)
        vidle = (k == 4 and tonumber(v)) or vidle
        k = k + 1
    end
    local dtotal, didle = vtotal - cpuv.total, vidle - cpuv.idle
    local cpustr = ' ' .. tostring(cpuv.pct) .. '%'
    if dtotal > 1500 or cpuv.total == 0 then
        cpuv.pct = math.floor(0.5 + 100 * (dtotal - didle) / dtotal)
        cpuv.total, cpuv.idle = vtotal, vidle
        if cpuv.total ~= 0 then
            cpustr = cpustr:sub(1, 4) .. tostring(cpuv.pct) .. '%'
        end
    end
    local segments = segments_for_right_status(window, memstr, cpustr)
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
