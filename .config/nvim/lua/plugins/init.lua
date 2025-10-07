return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("plugins.conf.treesitter")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("plugins.conf.formatter")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("plugins.conf.nvim-lint")
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"catgoose/nvim-colorizer.lua",
		opts = {
			filetypes = { "lua", "html", "js", "jsx", "ts", "svelte", "css", "tsx" },
			tailwind = true,
		},
	},
	{
		"echasnovski/mini.pick",
		dependencies = { "echasnovski/mini.extra" },
		config = function()
			require("mini.pick").setup()
			require("mini.extra").setup()
			vim.keymap.set("n", "<leader>?", ":Pick help<CR>", { silent = true })
			vim.keymap.set("n", "<leader><leader>", ":Pick buffers<CR>", { silent = true })
			vim.keymap.set("n", "<leader>ft", ":Pick git_files<CR>", { silent = true })
			vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { silent = true })
			vim.keymap.set("n", "<leader>fw", ":Pick grep<CR>", { silent = true })
			vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { silent = true })
			vim.keymap.set("n", "<leader>fd", ":Pick diagnostic<CR>", { silent = true })
		end,
	},
}
