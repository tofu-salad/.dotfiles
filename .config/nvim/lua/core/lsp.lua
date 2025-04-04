vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
		-- keybinds
		map("<leader>lr", vim.lsp.buf.rename, "[l]sp [r]ename")
		map("<leader>la", vim.lsp.buf.code_action, "[l]sp code [a]ction")

		map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
		map("gI", vim.lsp.buf.implementation, "[g]oto [I]mplementation")
		map("<leader>D", vim.lsp.buf.type_definition, "type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")

		-- see `:help K` for why this keymap
		map("K", vim.lsp.buf.hover, "hover documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "signature documentation")

		-- lesser used lsp functionality
		map("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")
		map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
		map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
		map("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[w]orkspace [l]ist folders")
	end,
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.enable({ "lua_ls", "rust_analyzer", "nixd", "cssls", "gopls", "ts_ls" })
