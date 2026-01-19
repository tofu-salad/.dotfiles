local ts = require("nvim-treesitter")

local ignore_parsers = {
	jsonc = true,
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(ctx)
		local ft = ctx.match
		if not ft or ft == "" then
			return
		end

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang or ignore_parsers[lang] then
			return
		end

		local available_parsers = ts.get_available()
		if not vim.tbl_contains(available_parsers, lang) then
			return
		end

		local installed = ts.get_installed("parsers")
		if not vim.tbl_contains(installed, lang) then
			ts.install({ lang })
			return
		end

		pcall(vim.treesitter.start, ctx.buf)
		vim.bo[ctx.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
	end,
})
