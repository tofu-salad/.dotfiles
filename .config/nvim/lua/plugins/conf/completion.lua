local blink_cmp = require("blink.cmp")
blink_cmp.setup({
	keymap = { preset = "default" },
	completion = {
		menu = {
			auto_show = function(ctx)
				return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
			end,
		},
	},
	sources = {
		cmdline = {},
	},

	appearance = {
		-- kind_icons = {
		-- Text = "[text]",
		-- Method = "[method]",
		-- Function = "[funct]",
		-- Constructor = "[constructor]",
		-- Field = "[field]",
		-- Variable = "[variable]",
		-- Property = "[property]",
		-- Class = "[class]",
		-- Interface = "[interface]",
		-- Struct = "[struct]",
		-- Module = "[module]",
		-- Unit = "[unit]",
		-- Value = "[value]",
		-- Enum = "[enum]",
		-- EnumMember = "[enummember]",
		-- Keyword = "[keyword]",
		-- Constant = "[constant]",
		--
		-- Snippet = "[snippet]",
		-- Color = "[color]",
		-- File = "[file]",
		-- Reference = "[reference]",
		-- Folder = "[folder]",
		-- Event = "[event]",
		-- Operator = "[operator]",
		-- TypeParameter = "[typeparameter]",
		-- },
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
})
