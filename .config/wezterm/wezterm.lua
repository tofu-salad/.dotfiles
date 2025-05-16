local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action
local success, sessionizer_module = pcall(require, "wezterm-sessionizer")
local sessionizer
if success then
	sessionizer = sessionizer_module.sessionizer
end

config.default_prog = { "bash" }
config.window_padding = {
	top = 4,
	bottom = 0,
}
config.font = wezterm.font("IosevkaTerm Nerd Font Mono")
config.font_size = 12
config.color_scheme = "Oxocarbon Dark (Gogh)"
local scheme = wezterm.color.get_builtin_schemes()["Oxocarbon Dark (Gogh)"]
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = 'NeverPrompt'

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.tab_index
	local title = tab_title(tab)
	if tab.is_active then
		return {
			{ Background = { Color = scheme.background } },
			{ Foreground = { Color = scheme.ansi[2] } },
			{ Text = " " .. index },
			{ Foreground = { Color = scheme.foreground } },
			{ Text = ":" },
			{ Text = wezterm.truncate_right(title, max_width - 4) },
			{ Foreground = { Color = scheme.ansi[7] } },
			{ Text = "*" },
		}
	end
	return {
		{ Background = { Color = scheme.background } },
		{ Foreground = { Color = scheme.ansi[2] } },
		{ Text = " " .. index },
		{ Foreground = { Color = scheme.ansi[1] } },
		{ Text = ":" },
		{ Foreground = { Color = scheme.cursor_bg } },
		{ Text = title },
	}
end)

config.colors = {
	tab_bar = {
		background = scheme.background,
	},
}

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if sessionizer then
				sessionizer(window, pane)
			else
				window:toast_notification("Error", "Sessionizer module not loaded", nil, 4000)
			end
		end),
	},
}

for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i),
	})
end

wezterm.on("update-right-status", function(window, pane)
	local workspace = window:active_workspace()
	local text = " 󱂬 " .. workspace .. " "
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = scheme.ansi[5] } },
		{ Text = text },
	}))

	if workspace == "default" then
		window:set_config_overrides({
			hide_tab_bar_if_only_one_tab = true,
		})
	else
		window:set_config_overrides({
			hide_tab_bar_if_only_one_tab = false,
		})
	end
end)

config.unix_domains = {
  {
    name = 'unix',
  },
}
config.default_gui_startup_args = { 'connect', 'unix' }

return config
