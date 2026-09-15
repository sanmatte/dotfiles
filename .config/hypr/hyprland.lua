-- Hyprland configuration

hl.config({
    ecosystem = {
        no_donation_nag = true,
    },
})

-- Built-in display
hl.monitor({
    output = "eDP-1",
    mode = "1920x1200",
    position = "auto",
    scale = 1.25,
})

-- Applications
local terminal = "kitty"
local fileManager = "nautilus --new-window"
local browser = "flatpak run app.zen_browser.zen"
local messenger = "flatpak run com.slack.Slack"
local slackSelector = [[class:^(Slack|slack|com\.slack\.Slack)$]]

-- Startup
hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    -- Automount removable drives
    hl.exec_cmd("sh -c 'sleep 2 && udiskie --tray'")
end)

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "macOS_hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")

-- Appearance
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = "rgba(aaaaaaee)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 3,
            passes = 3,
            new_optimizations = true,
            vibrancy = 0.1696,
            ignore_opacity = true,
        },
    },
    animations = {
        enabled = true,
    },
})

-- Animation curves
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "wind" })

-- Layout
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

-- Miscellaneous
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        focus_on_activate = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Input
hl.config({
    input = {
        kb_layout = "it",
        kb_options = "ctrl:nocaps,shift:both_capslock",
        follow_mouse = 1,
        sensitivity = 0.2,
        touchpad = {
            natural_scroll = true,
            drag_lock = 0,
            tap_to_click = true,
        },
    },
})

-- Three-finger workspace swipe
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({ name = "tpps/2-elan-trackpoint", sensitivity = -0.5 })

-- Noctalia integration
hl.layer_rule({
    name = "noctalia",
    match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$" },
    no_anim = true,
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.5,
})

hl.window_rule({
    name = "noctalia-settings",
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = "1080 920",
})

-- Keybindings
local mainMod = "SUPER"

-- Application shortcuts
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(
    terminal .. " --theme=BlueBerryPie --background-opacity=0.9 --initial-command=\"zsh -c 'ssh ctf-vm'\""
))
hl.bind(mainMod .. " + M", function()
    local active = hl.get_active_window()

    -- Hide Slack when it is already focused
    if active ~= nil and (
        active.class == "Slack" or
        active.class == "slack" or
        active.class == "com.slack.Slack"
    ) then
        hl.dispatch(hl.dsp.window.move({
            window = active,
            workspace = "special:slack-background",
            follow = false,
        }))
        return
    end

    local slack = hl.get_window(slackSelector)

    -- Start Slack when it is not running
    if slack == nil then
        hl.dispatch(hl.dsp.exec_cmd(messenger))
        return
    end

    -- Bring Slack to the current workspace instead of switching to its workspace
    local currentWorkspace = hl.get_active_workspace()
    hl.dispatch(hl.dsp.window.move({
        window = slack,
        workspace = currentWorkspace,
        follow = false,
    }))
    hl.dispatch(hl.dsp.focus({ window = slack }))
end)

hl.bind(mainMod .. " + A", hl.dsp.focus({ window = "class:.*[Zz]en.*" }))

-- Window management
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.swap({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 10, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.resize({ x = -10, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -10 }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 10 }), { repeating = true })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Noctalia shortcuts
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("noctalia msg settings-toggle"))
hl.bind("ALT + space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher \"/ssh \""))

-- Workspaces
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + Page_Up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + Page_Down", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + Page_Up", hl.dsp.window.move({ workspace = "-1" }))

-- SUPER+1..0 switches workspaces; SHIFT moves the active window
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("noctalia msg screenshot-window"))

-- Media and brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Window rules

-- Slack floats on the right side
hl.window_rule({
    name = "slack-float",
    match = { class = "^(Slack|slack|com\\.slack\\.Slack)$" },
    float = true,
    no_anim = true,
		size = {
        "monitor_w * 0.90",
        "monitor_h * 0.90",
    },
    move = "100%-w-0.8% 4%",
})

-- Keep dnSpy tiled
hl.window_rule({
    name = "dnspy-tile",
    match = { class = "^dnspy.exe$" },
    tile = true,
})

-- Hide XWaylandVideoBridge helper windows
hl.window_rule({
    name = "xwaylandvideobridge-fix",
    match = { class = "^xwaylandvideobridge$" },
    opacity = "0.0",
    no_anim = true,
    no_initial_focus = true,
    no_focus = true,
    max_size = "1 1",
    no_blur = true,
})

-- Prevent IDA from stealing focus
hl.window_rule({
    name = "ida-no-steal-focus",
    match = { class = "^IDA$" },
    focus_on_activate = false,
})

-- Float Thunderbird compose windows
hl.window_rule({
    name = "thunderbird-compose-float",
    match = { class = "thunderbird", title = "Write.*" },
    float = true,
    size = "1000 800",
})

-- Kitty opacity
hl.window_rule({
    name = "kitty-opacity",
    match = { class = "^kitty$" },
    opacity = "0.9 0.8",
})

-- Open Zen Browser on workspace 2
hl.window_rule({
    name = "zen-browser-workspace",
    match = { class = "^app.zen_browser.zen$" },
    workspace = "2",
})

