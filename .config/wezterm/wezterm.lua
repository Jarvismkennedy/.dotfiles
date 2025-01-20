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
local is_macos = os.capture 'uname' == 'Darwin'

local home = os.getenv 'HOME'
local fd = '/usr/bin/fd'
local work = home .. '/work'
local personal = home .. '/personal'
local dots = home .. '/.dotfiles'
if is_macos then
    home = os.getenv 'HOME'
    fd = '/usr/local/bin/fd'
    work = home .. '/documents/dv8energyinc'
    personal = home .. '/personal'
    dots = home .. '/.dotfiles'
end

local toggle = function(window, pane)
    wezterm.log_info 'testing the toggle'
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

    wezterm.log_error('Failed to run fd: ' .. stderr)
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

local config = {}
config.use_ime = false
config.debug_key_events = true
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

    {
        key = 'm',
        mods = 'CTRL|META',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'n',
        mods = 'CTRL|META',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'e',
        mods = 'CTRL|META',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'i',
        mods = 'CTRL|META',
        action = wezterm.action.ActivatePaneDirection 'Right',
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
    { family = 'JetBrains Mono', weight = 'Medium', scale = 1.0 },
    'Symbols Nerd Font mono',
}
config.warn_about_missing_glyphs = true
local font_size = 12
if is_macos then
    font_size = 14
end
config.font_size = font_size
config.color_scheme = 'rose-pine-moon'
--
-- config.color_scheme = 'Catppuccin Mocha'
config.force_reverse_video_cursor = true
config.use_fancy_tab_bar = false
-- config.color_scheme = 'OneDark'
config.enable_tab_bar = true
-- config.tab_bar_at_bottom = true

local function segments_for_right_status(window, mem, cpu, cputmp)
    return {
        window:active_workspace(),
        wezterm.strftime '%a %b %-d %H:%M',
        mem,
        cpu,
        cputmp,
    }
end

-- taken from github issue on sys info functionality request.
local memmb = { Total = 0, Available = 0 }
local cpuv = { total = 0, idle = 0, pct = 1 }
wezterm.on('update-status', function(window, _)
    local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

    local color_scheme = window:effective_config().resolved_palette
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    local gradient_to = bg
    local gradient_from = gradient_to:lighten(0.2)

    local segments = {}

    if not is_macos then
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

        local _, cputmp, _ = wezterm.run_child_process { '/home/jk/.scripts/arch_amd_cpu_tmp' }
        local dtotal, didle = vtotal - cpuv.total, vidle - cpuv.idle
        local cpustr = ' ' .. tostring(cpuv.pct) .. '%'

        if dtotal > 1500 or cpuv.total == 0 then
            cpuv.pct = math.floor(0.5 + 100 * (dtotal - didle) / dtotal)
            cpuv.total, cpuv.idle = vtotal, vidle
            if cpuv.total ~= 0 then
                cpustr = cpustr:sub(1, 4) .. tostring(cpuv.pct) .. '%'
            end
        end
        segments = segments_for_right_status(window, memstr, cpustr, cputmp:match '%d+.%d+°C')
    else
        segments = segments_for_right_status(window, 'N/A', 'N/A', 'N/A')
    end
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
