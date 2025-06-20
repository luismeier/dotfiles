-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme_dirs = { "/home/luism/.config/wezterm/colors" }
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "catppuccin-macchiato"
config.color_scheme = "nordfox"
-- config.color_scheme = "nightfox"

-- config.font = wezterm.font("Fira Code NerdFont mono")
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 11

config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
