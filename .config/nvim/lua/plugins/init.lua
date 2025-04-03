return {
	-- git plugins
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>ga", "<cmd>Git<CR>")
			vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
			vim.keymap.set("n", "<leader>gm", "<cmd>Git mergetool<CR>")
			vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>")
		end,
	},
	"tpope/vim-sleuth",
	{
		"williamboman/mason.nvim",
		lazy = true,
		cmd = "Mason",
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 100,
					zindex = 55,
				},
			},
		},
	},
	-- format and lint
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
	-- autocompletion
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		config = function()
			require("plugins.conf.completion")
		end,
	},
	-- highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		config = function()
			require("plugins.conf.treesitter")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("plugins.conf.telescope")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		keys = { "<leader>h" },
		config = function()
			require("plugins.conf.harpoon")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.conf.colorizer")
		end,
	},
	{
		"echasnovski/mini.statusline",
		config = function()
			require("plugins.conf.statusline")
		end,
	},
	require("plugins.conf.themes"),
}
