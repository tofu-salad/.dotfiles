require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = false },
		html = { "prettierd", "prettier", stop_after_first = false },
		json = { "prettierd", "prettier", stop_after_first = false },
		jsonc = { "jq", "prettierd", stop_after_first = false },
		gotmpl = { "prettierd", "prettier", stop_after_first = false },
		javascriptreact = { "prettierd", "prettier", stop_after_first = false },
		typescript = { "prettierd", "prettier", stop_after_first = false },
		typescriptreact = { "prettierd", "prettier", stop_after_first = false },
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		sql = { "sql_formatter" },
	},
})
