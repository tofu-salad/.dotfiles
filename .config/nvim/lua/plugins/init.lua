return {
	-- Git plugins
	require("plugins.conf.themes"),
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.conf.gitsigns")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("plugins.conf.colorizer")
		end,
	},
	"tpope/vim-fugitive",
	"tpope/vim-sleuth",
	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			require("plugins.conf.lsp")
		end,
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
	-- Format and Lint
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
	-- Autocompletion
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		config = function()
			require("plugins.conf.completion")
		end,
	},
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		-- Snippet Engine & its associated nvim-cmp source
	-- 		"L3MON4D3/LuaSnip",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		-- Adds LSP completion capabilities
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		"hrsh7th/cmp-path",
	-- 		"hrsh7th/cmp-nvim-lua",
	-- 		"hrsh7th/cmp-cmdline",
	-- 		"hrsh7th/cmp-buffer",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.conf.cmp")
	-- 	end,
	-- },

	-- Highlight, edit, and navigate code
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
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			require("mini.ai").setup()
			-- Status Line
			require("plugins.conf.statusline")

			-- Comment
			require("plugins.conf.comment")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		keys = { "<leader>h" },
		config = function()
			require("plugins.conf.harpoon")
		end,
	},
}
