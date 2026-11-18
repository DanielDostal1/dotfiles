-- Monitors
local mainMonitor = "DP-1"
local secondaryMonitor = "DP-2"

hl.monitor({ output = secondaryMonitor, mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = mainMonitor, mode = "1920x1080@165", position = "1920x0", scale = 1 })

-- Programs
local browser = "firefox"
local terminal = "kitty"
local fileManager = "nautilus"
local menu = "wofi --show drun"

-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Look and feel / input
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border = "rgb(999999)",
            inactive_border = "rgb(333333)",
        },
        layout = "dwindle",
    },
    decoration = {
        active_opacity = 1.0,
        inactive_opacity = 1.0,
    },
    animations = {
        enabled = false,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    input = {
        kb_layout = "us,sk(qwerty)",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:escape,grp:win_space_toggle",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = -0.5,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({ name = "logitech-gaming-mouse-g502", sensitivity = 0 })

-- No gaps, borders or rounding for a single tiled/fullscreen window.
for _, workspace in ipairs({ "w[tv1]", "f[1]" }) do
    hl.workspace_rule({ workspace = workspace, gaps_out = 0, gaps_in = 0 })
    hl.window_rule({
        match = { float = false, workspace = workspace },
        border_size = 0,
        rounding = 0,
    })
end

-- Keybindings
local mainMod = "SUPER"
local altMod = "ALT"

hl.bind("XF86RFKill", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Launch apps
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/ --freeze"))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Move focus with Vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Switch workspaces / move the active window and follow it
local workspaceKeys = { "J", "M", "COMMA", "PERIOD", "SLASH", "Z", "X", "C", "V", "F" }
for workspace, key in ipairs(workspaceKeys) do
    hl.bind(altMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(altMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = true }))
end

-- Scratchpad and mouse bindings
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + M", hl.dsp.workspace.move({ monitor = "+1" }))

-- Volume and brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"))

-- Media keys also work while locked
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Workspace monitor assignments
for workspace = 1, 9 do
    hl.workspace_rule({ workspace = tostring(workspace), monitor = mainMonitor, default = workspace == 1 })
end
hl.workspace_rule({ workspace = "10", monitor = secondaryMonitor, default = true })

-- Autostart (only runs at compositor startup, not on config reload)
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync & hypridle & hyprpaper & blueman-applet")
    hl.exec_cmd(browser, { workspace = "1 silent" })
    hl.dispatch(hl.dsp.focus({ workspace = 1 }))
    hl.exec_cmd(terminal, { workspace = "2 silent" })
end)
