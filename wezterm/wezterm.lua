-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- If Windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  -- Default program
  config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-l" }
end

--------------- Appearance ---------------
-- Color scheme
config.color_scheme = "Dracula"

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 2
config.tab_and_split_indices_are_zero_based = true

-- Window
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

--------------- Keybingings ---------------
config.disable_default_key_bindings = true
-- Universal modifier for terminal actions
KeyModifier = "CTRL|SHIFT"
local act = wezterm.action
config.keys = {
	-- Command palette
	{ key = "p", mods = KeyModifier, action = act.ActivateCommandPalette },
	-- Debug overlay
	{ key = "l", mods = KeyModifier, action = act.ShowDebugOverlay },
	-- Tabs
	{ key = "t", mods = KeyModifier, action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = KeyModifier, action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "RightArrow", mods = KeyModifier, action = act.ActivateTabRelative(1) },
	{ key = "LeftArrow", mods = KeyModifier, action = act.ActivateTabRelative(-1) },
	-- Splits
	{ key = "e", mods = KeyModifier, action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = KeyModifier, action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "z", mods = KeyModifier, action = act.TogglePaneZoomState },
	-- Other
	{ key = "x", mods = KeyModifier, action = act.ActivateCopyMode },
	{ key = "u", mods = KeyModifier, action = act.CharSelect },
	{ key = "k", mods = KeyModifier, action = act.ClearScrollback("ScrollbackOnly") },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "c", mods = KeyModifier, action = act.CopyTo("Clipboard") },
	{ key = "v", mods = KeyModifier, action = act.PasteFrom("Clipboard") },
}

-- and finally, return the configuration to wezterm
return config
