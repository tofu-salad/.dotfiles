vim.filetype.add({
	extension = { rasi = "rasi" },
	pattern = {
		[".*/waybar/.*/*.conf"] = "jsonc",
		[".*/waybar/config"] = "jsonc",
		[".*/mako/config"] = "dosini",
		[".*/kitty/*.conf"] = "bash",
		[".*/hypr/.*%.conf"] = "hyprlang",
	},
})

vim.filetype.add({
	extension = { rasi = "rasi" },
	pattern = {
		["~/.config/waybar/config"] = "jsonc",
	},
})

vim.filetype.add({
	extension = { conf = "swayconfig" },
	pattern = {
		["~/.config/sway/config"] = "swayconfig",
		["~/.config/sway/conf.d/*.conf"] = "swayconfig",
	},
})
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

vim.filetype.add({
	extension = { gotmpl = "gotmpl" },
	pattern = {
		[".*"] = function(path)
			local root_dir = vim.fn.getcwd()
			local go_mod_path = root_dir .. "/go.mod"

			if vim.fn.filereadable(go_mod_path) == 1 and path:match("%.html$") then
				return "gotmpl"
			end
		end,
	},
})
