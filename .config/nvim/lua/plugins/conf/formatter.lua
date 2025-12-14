local function no_trailing_comma_for_json(_, ctx)
	return ctx.filename:match("%.jsonc?$") and { "--trailing-comma=none" } or {}
end

require("conform").formatters.jq = {
	inherit = false,
	command = "jq",
	args = { "--indent", "4" },
}
require("conform").setup({
	formatters = {
		prettierd = {
			prepend_args = no_trailing_comma_for_json,
		},
		prettier = {
			prepend_args = no_trailing_comma_for_json,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		json = { "prettierd", "prettier", "jq" },
		jsonc = { "prettierd", "jq" },
		gotmpl = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		sh = { "shfmt" },
		sql = { "sql_formatter" },
		qml = { "qmlformat" },
	},
})

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range, stop_after_first = true })
end, { range = true })

vim.keymap.set("n", "<leader>lf", "<cmd>Format<CR>", { desc = "[l][f]ormat" })
