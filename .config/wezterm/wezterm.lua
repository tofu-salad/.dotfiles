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

-- For example, changing the color scheme:
-- config.color_scheme = "carbonfox"
config.color_scheme = 'Oxocarbon Dark (Gogh)'
-- config.text_background_opacity = 0
-- config.window_background_opacity = 0
config.enable_tab_bar = false
config.enable_wayland = true
config.font_size = 10
config.window_close_confirmation = 'NeverPrompt'
local dimmer = { brightness = 0.008 }
config.background = {
	-- This is the deepest/back-most layer. It will be rendered first
	{
		source = {
			Color = "Black",
		},
		width = "100%",
		height = "100%",
	},
	{
		source = {
			File = "/home/tofu/Pictures/anime/rocketgurl.png",
		},
		repeat_x = "NoRepeat",
		repeat_y = "NoRepeat",
		width = "640",
		height = "100%",
		vertical_align = "Middle",
		horizontal_align = "Center",
		hsb = dimmer,
		attachment = "Fixed",
	},
}

return config
