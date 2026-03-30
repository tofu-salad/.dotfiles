vim.filetype.add({
	extension = {
		rasi = "rasi",
		templ = "templ",
		gotmpl = "gotmpl",
		conf = "swayconfig",
		-- shaders
		vs = "glsl",
		fs = "glsl",
		vert = "glsl",
		frag = "glsl",
		geom = "glsl",
		comp = "glsl",
	},
	pattern = {
		-- waybar
		[".*/waybar/.*/*.conf"] = "jsonc",
		[".*/waybar/config"] = "jsonc",
		["~/.config/waybar/config"] = "jsonc",
		-- mako
		[".*/mako/config"] = "dosini",
		-- kitty
		[".*/kitty/*.conf"] = "bash",
		-- hyprland
		[".*/hypr/.*%.conf"] = "hyprlang",
		-- sway
		["~/.config/sway/config"] = "swayconfig",
		["~/.config/sway/conf.d/*.conf"] = "swayconfig",
		-- go templates
		[".*"] = function(path)
			local go_mod = vim.fn.getcwd() .. "/go.mod"
			if vim.fn.filereadable(go_mod) == 1 and path:match("%.html$") then
				return "gotmpl"
			end
		end,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
	callback = function()
		vim.o.tabstop = 4
	end,
})
