return {
	--- Git plugins
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
	--- LSP
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
					winblend = 0,
					zindex = 55,
				},
			},
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
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
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			require("plugins.conf.cmp")
		end,
	},

	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/playground",
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
		keys = { { "<leader>a", mode = "n" }, { "C-e", mode = "n" } },
		config = function()
			require("plugins.conf.harpoon")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("plugins.conf.transparent")
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local oxocarbon = require("oxocarbon")
			vim.opt.background = "dark"
			vim.cmd.colorscheme("oxocarbon")
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = oxocarbon.oxocarbon.base02 })
			vim.api.nvim_set_hl(0, "LineNr", { fg = oxocarbon.oxocarbon.base05 })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = oxocarbon.oxocarbon.base02 })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = oxocarbon.oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = oxocarbon.oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = oxocarbon.oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = oxocarbon.oxocarbon.blend })
			vim.api.nvim_set_hl(
				0,
				"TelescopePreviewTitle",
				{ fg = oxocarbon.oxocarbon.base00, bg = oxocarbon.oxocarbon.base12 }
			)
			vim.api.nvim_set_hl(
				0,
				"TelescopePromptTitle",
				{ fg = oxocarbon.oxocarbon.base08, bg = oxocarbon.oxocarbon.blend }
			)
			vim.api.nvim_set_hl(
				0,
				"TelescopeResultsTitle",
				{ fg = oxocarbon.oxocarbon.base00, bg = oxocarbon.oxocarbon.base08 }
			)
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
}
