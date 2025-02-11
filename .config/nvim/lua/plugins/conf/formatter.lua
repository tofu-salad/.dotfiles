require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		jsonc = { "jq", "prettierd" },
		gotmpl = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		sql = { "sql_formatter" },
	},
	default_format_opts = {
		lsp_format = "fallback",
		stop_after_first = true,
	},
})

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format()
end, { desc = "[l]sp custom [f]ormat" })
