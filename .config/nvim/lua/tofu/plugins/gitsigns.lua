local pack = require("tofu.pack")

pack.add_gh("lewis6991/gitsigns.nvim")
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
	},
})
