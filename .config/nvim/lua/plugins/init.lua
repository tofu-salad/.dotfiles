return {
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
	{
		"datsfilipe/vesper.nvim",
		config = function()
			require("vesper").setup({
				transparent = false, -- Boolean: Sets the background to transparent
				italics = {
					comments = true, -- Boolean: Italicizes comments
					keywords = false, -- Boolean: Italicizes keywords
					functions = false, -- Boolean: Italicizes functions
					strings = false, -- Boolean: Italicizes strings
					variables = false, -- Boolean: Italicizes variables
				},
				overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
				palette_overrides = {
					bg = "#161616",
				},
			})
			vim.cmd.colorscheme("vesper")
		end,
	},
	-- {
	-- 	"nyoom-engineering/oxocarbon.nvim",
	-- 	config = function()
	-- 		-- vim.opt.background = "dark"
	-- 		-- vim.cmd.colorscheme("oxocarbon")
	-- 	end,
	-- },
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
