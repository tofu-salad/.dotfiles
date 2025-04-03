local blink_cmp = require("blink.cmp")
blink_cmp.setup({
	keymap = { preset = "default" },
	completion = {
		menu = {
			auto_show = function(ctx)
				return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
			end,
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
			},
		},
	},
	cmdline = {
		enabled = false,
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
})
