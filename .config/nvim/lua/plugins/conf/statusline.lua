local active = function()
	local MiniStatusline = require("mini.statusline")

	local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 100 })
	local git = MiniStatusline.section_git({ trunc_width = 40 })
	local diff = MiniStatusline.section_diff({ trunc_width = 75 })
	local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
	local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
	local filename = MiniStatusline.section_filename({ trunc_width = 140 })
	local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
	local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

	return MiniStatusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "NONE", strings = { git, diff, diagnostics, lsp } },
		"%<",
		"%=",
		{ hl = "NONE", strings = { filename } },
		"%=",
		{ hl = "NONE", strings = { fileinfo } },
		{ hl = "NONE", strings = { search, "%P" } },
	})
end

require("mini.statusline").setup({
	content = { active = active },
})
