-- typescript comments
require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
local get_option = vim.filetype.get_option

---@diagnostic disable-next-line: duplicate-set-field
vim.filetype.get_option = function(filetype, option)
	return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
		or get_option(filetype, option)
end

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
	sync_install = false,
	auto_install = true,
	ignore_install = { "jsonc" },
	highlight = {
		enable = true,
		disable = {},
	},
	indent = { enable = true },
})
