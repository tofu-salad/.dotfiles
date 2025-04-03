vim.opt.laststatus = 3
local active = function()
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
