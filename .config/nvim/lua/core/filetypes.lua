-- additional filetypes
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

vim.filetype.add({
	extension = {
		gohtmltmpl = "gohtmltmpl",
	},
})

vim.filetype.add({
	extension = {
		gotmpl = "gohtmltmpl",
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
