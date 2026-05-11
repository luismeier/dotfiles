local terminal = "kitty"
local fileManager = "dolphin"
local mainMod = "SUPER"

-- launcher (rofi)
hl.bind("ALT + space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("pkill rofi || rofi -show window"))

-- keybinds for application launch
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. " -e 'nvim'"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(
	mainMod .. " + O",
	hl.dsp.exec_cmd(os.getenv("HOME") .. '/.local/bin/launch_or_focus "obsidian" -- flatpak run md.obsidian.Obsidian')
)
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd(
		os.getenv("HOME") .. '/.local/bin/launch_or_focus "tidal" -- flatpak run com.mastermindzh.tidal-hifi'
	)
)
hl.bind(
	mainMod .. " + A",
	hl.dsp.exec_cmd("flatpak run --command=io.github.alainm23.planify.quick-add io.github.alainm23.planify")
)
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("~/.config/hypr/scripts/fix_hw_cursor.sh"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(os.getenv("XDG_CONFIG_HOME") .. "/hypr/scripts/wallpaper_sw.sh"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor-select"))

-- Clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot-cmd"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot-cmd window"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.local/bin/screenshot-cmd monitor"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Locking and session management
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd(os.getenv("XDG_CONFIG_HOME") .. "/rofi/powermenu.sh"))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))

-- Window stuff
hl.bind(mainMod .. " + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())

-- Master layout
hl.bind(mainMod .. " + T", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.layout("orientationcycle left top right"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.layout("orientationleft"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i })) -- switch workspace
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i })) -- move window to workspace
end

-- move current workspace to sccreen
hl.bind(mainMod .. " + CTRL + left", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.workspace.move({ monitor = "d" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.workspace.move({ monitor = "u" }))
hl.bind(mainMod .. " + CTRL + h", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.workspace.move({ monitor = "d" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.workspace.move({ monitor = "u" }))

-- next workspace on monitor
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ workspace = "m-1" }))

-- special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch to a submap called `resize`.
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 10, y = -10, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
	-- hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Monitor brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 set 5%-"), { locked = true, repeating = true })

-- playback and pause
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
