return {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = vim.fn.executable("oxfmt") ~= 1
	end,
}
