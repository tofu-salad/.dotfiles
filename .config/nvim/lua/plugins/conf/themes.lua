return {
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
				overrides = {
				}, -- A dictionary of group names, can be a function returning a dictionary or a table.
				palette_overrides = {
					bg = "#161616"
				},
			})
			vim.cmd.colorscheme("vesper")
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			local oxocarbon = require("core.utils").base16.oxocarbon.dark

			vim.opt.background = "dark"
			-- vim.cmd.colorscheme("oxocarbon")

			-- Telescope fix
			vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = oxocarbon.base02, bg = oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = oxocarbon.base02, bg = oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = oxocarbon.blend })
			vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = oxocarbon.base03, bg = oxocarbon.base08 })

			-- Markdown fix
			for l = 1, 6 do
				vim.api.nvim_set_hl(0, "@markup.heading." .. l .. ".markdown", { fg = oxocarbon.base03, bold = true })
			end
			vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = oxocarbon.base07 })
			vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", { underline = false })
			vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = oxocarbon.base14, underline = false })
			vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = oxocarbon.base14 })

			-- CMP Colors
			-- #525252
			vim.api.nvim_set_hl(
				0,
				"CmpItemAbbrDeprecated",
				{ bg = "NONE", strikethrough = true, fg = oxocarbon.base03 }
			)

			-- #BE95FF
			vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = oxocarbon.base14 })
			vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
			vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
			vim.api.nvim_set_hl(0, "CmpItemKindFile", { link = "CmpItemKindVariable" })

			-- #82CFFF
			vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = oxocarbon.base15 })
			vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindFunction" })
			vim.api.nvim_set_hl(0, "CmpItemKindValue", { link = "CmpItemKindFunction" })

			-- #78A9FF
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = oxocarbon.base09 })
			vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
			vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
			vim.api.nvim_set_hl(0, "CmpItemKindEnum", { link = "CmpItemKindKeyword" })

			-- #FF7EB6
			vim.api.nvim_set_hl(0, "CmpItemKindField", { bg = "NONE", fg = oxocarbon.base12 })
			vim.api.nvim_set_hl(0, "CmpItemKindEvent", { link = "CmpItemKindField" })

			-- #42be65
			vim.api.nvim_set_hl(0, "CmpItemKindFolder", { bg = "NONE", fg = oxocarbon.base13 })
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { link = "CmpItemKindFolder" })

			-- #33B1FF
			vim.api.nvim_set_hl(0, "CmpItemKindModule", { bg = "NONE", fg = oxocarbon.base11 })
			vim.api.nvim_set_hl(0, "CmpItemKindClass", { link = "CmpItemKindModule" })
			vim.api.nvim_set_hl(0, "CmpItemKindStruct", { link = "CmpItemKindModule" })
			vim.api.nvim_set_hl(0, "CmpItemKindOperator", { link = "CmpItemKindModule" })

			-- #EE5396
			vim.api.nvim_set_hl(0, "CmpItemKindConstant", { bg = "NONE", fg = oxocarbon.base10 })
			vim.api.nvim_set_hl(0, "CmpItemKindReference", { link = "CmpItemKindConstant" })
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { link = "CmpItemKindConstant" })

			-- #3DDBD9
			vim.api.nvim_set_hl(0, "CmpItemKindColor", { bg = "NONE", fg = oxocarbon.base08 })
			vim.api.nvim_set_hl(0, "CmpItemKindParameter", { link = "CmpItemKindColor" })
			vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { link = "CmpItemKindColor" })
		end,
	},
}
