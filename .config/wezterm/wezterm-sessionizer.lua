local wezterm = require("wezterm")
local act = wezterm.action

local function is_directory(path)
	local f = io.open(path, "r")
	if f then
		local _, _, code = f:read(1)
		f:close()
		return code == 21
	end
	return false
end

local function get_project_directories()
	local home = wezterm.home_dir

	local paths = {
		home .. "/Code",
		home .. "/Code/Github",
		home .. "/Diego/Code",
	}

	local projects = {
		{ id = "default", label = "default" },
	}
	for _, path in ipairs(paths) do
		local success, entries = pcall(wezterm.read_dir, path)
		if success then
			for _, entry in ipairs(entries) do
				if not entry:match("^%.") then
					if is_directory(entry) then
						table.insert(projects, {
							id = entry,
							label = entry,
						})
					end
				end
			end
		end
	end

	return projects
end

-- The main sessionizer function
local function sessionizer(window, pane)
	local projects = get_project_directories()

	if #projects == 0 then
		window:toast_notification("Sessionizer Error", "No projects found", nil, 4000)
		return
	end

	window:perform_action(
		act.InputSelector({
			title = "picker",
			action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
				if not id then
					return
				end

				local workspace_name = label:gsub("%.", "_")

				inner_window:perform_action(
					act.SwitchToWorkspace({
						name = workspace_name,
						spawn = {
							label = "Workspace: " .. workspace_name,
							cwd = id,
						},
					}),
					inner_pane
				)
			end),
			choices = projects,
			fuzzy = true,
			fuzzy_description = "> ",
		}),
		pane
	)
end

return {
	sessionizer = sessionizer,
}
