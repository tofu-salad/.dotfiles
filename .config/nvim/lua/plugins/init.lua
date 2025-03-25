return {
	-- git plugins
	{
		-- adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.conf.gitsigns")
		end,
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
	-- lsp
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
		priority = 1000,
		config = function()
			vim.opt.laststatus = 3
			local active = function()
				-- *This* is the place that gets adjusted
				local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 100 })
				local git = MiniStatusline.section_git({ trunc_width = 40 })
				local diff = MiniStatusline.section_diff({ trunc_width = 75 })
				local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
				local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
				local filename = MiniStatusline.section_filename({ trunc_width = 140 })
				local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
				local location = MiniStatusline.section_location({ trunc_width = 75 })
				local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

				return MiniStatusline.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "NONE", strings = { git, diff, diagnostics, lsp } },
					"%<", -- Mark general truncate point
					"%=",
					{ hl = "NONE", strings = { filename } },
					"%=", -- End left alignment
					{ hl = "NONE", strings = { fileinfo } },
					{ hl = "NONE", strings = { search, "%P" } },
				})
			end

			require("mini.statusline").setup({
				content = { active = active },
			})
		end,
	},
	require("plugins.conf.themes"),
}
