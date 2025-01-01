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
		-- 	Text = "text",
		-- 	Method = "method",
		-- 	Function = "fucntion",
		-- 	Constructor = "constructor",
		--
		-- 	Field = "field",
		-- 	Variable = "variable",
		-- 	Property = "property",
		--
		-- 	Class = "class",
		-- 	Interface = "interface",
		-- 	Struct = "struct",
		-- 	Module = "module",
		--
		-- 	Unit = "unit",
		-- 	Value = "value",
		-- 	Enum = "enum",
		-- 	EnumMember = "enummember",
		--
		-- 	Keyword = "keyword",
		-- 	Constant = "constant",
		--
		-- 	Snippet = "snippet",
		-- 	Color = "color",
		-- 	File = "file",
		-- 	Reference = "reference",
		-- 	Folder = "folder",
		-- 	Event = "event",
		-- 	Operator = "operator",
		-- 	TypeParameter = "typeparameter",
		-- },
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
})

-- See `:help cmp`
-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").lazy_load()
-- luasnip.config.setup({})
--
-- cmp.setup({
-- 	snippet = {
-- 		expand = function(args)
-- 			luasnip.lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-n>"] = cmp.mapping.select_next_item(),
-- 		["<C-p>"] = cmp.mapping.select_prev_item(),
-- 		["<C-d>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete({}),
-- 		["<C-y>"] = cmp.mapping.confirm({
-- 			behavior = cmp.ConfirmBehavior.Replace,
-- 			select = true,
-- 		}),
-- 	}),
-- 	sources = {
-- 		{ name = "nvim_lsp" },
-- 		{ name = "luasnip" },
-- 		{ name = "path" },
-- 		{ name = "nvim_lua" },
-- 		{ name = "buffer" },
-- 		-- { name = "cmdline" },
-- 	},
-- })
--
