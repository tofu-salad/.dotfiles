local oxocarbon = {
	base00 = "#161616",
	base01 = "#262626",
	base02 = "#393939",
	base03 = "#525252",
	base04 = "#dde1e6",
	base05 = "#d0d0d0",
	base06 = "#ffffff",
	base07 = "#08bdba",
	base08 = "#78a9ff",
	base09 = "#3ddbd9",
	base0A = "#ee5396",
	base0B = "#be95ff",
	base0C = "#78a9ff",
	base0D = "#ff7eb6",
	base0E = "#78a9ff",
	base0F = "#3ddbd9",
}
require("mini.base16").setup({
	palette = oxocarbon,

	use_cterm = nil,

	plugins = { default = true },
})
-- Number Lines
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = oxocarbon.base01 })
vim.api.nvim_set_hl(0, "LineNr", { fg = oxocarbon.base04 })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = oxocarbon.base01 })
vim.api.nvim_set_hl(0, "SignColumn", { fg = oxocarbon.base01 })

-- UI
vim.api.nvim_set_hl(0, "MsgArea", { fg = oxocarbon.base05 })

-- Telescope
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = oxocarbon.base00 })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = oxocarbon.base00 })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = oxocarbon.base00 })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = oxocarbon.base00 })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = oxocarbon.base00, bg = oxocarbon.base0F })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = oxocarbon.base0A, bg = oxocarbon.base00 })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = oxocarbon.base00, bg = oxocarbon.base0A })

-- Keywords
vim.api.nvim_set_hl(0, "@keyword.function", { fg = oxocarbon.base0F })
vim.api.nvim_set_hl(0, "@type", { fg = oxocarbon.base08 })

-- Other Syntax related things
vim.api.nvim_set_hl(0, "@operator", { fg = oxocarbon.base08 })
vim.api.nvim_set_hl(0, "CursorLineSign", { fg = oxocarbon.base08 })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = oxocarbon.base0F })
vim.api.nvim_set_hl(0, "@property", { fg = oxocarbon.base0A })

-- Netrw
vim.api.nvim_set_hl(0, "netrwDir", { fg = oxocarbon.base08 })
vim.api.nvim_set_hl(0, "netrwClassify", { fg = oxocarbon.base08 })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { fg = oxocarbon.base0A})
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = oxocarbon.base0A })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = oxocarbon.base00, fg = oxocarbon.base0A })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = oxocarbon.base00, fg = oxocarbon.base0B })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { bg = oxocarbon.base00, fg = oxocarbon.base0B })
vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { fg = oxocarbon.base05 })
vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { fg = oxocarbon.base05 })

-- Webdev
vim.api.nvim_set_hl(0, "Tag", { fg = oxocarbon.base08 })
