local pack = require("tofu.pack")

pack.add_gh("ibhagwan/fzf-lua")

require("fzf-lua").setup({
	winopts = {
		row = 1,
		col = 0,
		height = 0.5,
		width = 0.5,
		border = "single",
		preview = { hidden = true },
	},
})

vim.keymap.set("n", "<leader>ff", "<Cmd>FzfLua files<CR>", { desc = "[f]ind [f]iles" })
vim.keymap.set("n", "<leader>ft", "<Cmd>FzfLua git_files<CR>", { desc = "[f]ind gi[t] files" })
vim.keymap.set("n", "<leader>fg", "<Cmd>FzfLua live_grep<CR>", { desc = "[f]iles [g]rep" })
