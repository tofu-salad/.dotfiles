return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("plugins.conf.treesitter")
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring", -- typescript comments
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			local get_option = vim.filetype.get_option

			---@diagnostic disable-next-line: duplicate-set-field
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
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
	{
		"jesseleite/nvim-noirbuddy",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		lazy = false,
		priority = 1000,
		opts = {
			colors = {
				background = "#161616",
			},
		},
		install = { colorscheme = { "noirbuddy" } },
	},
}
