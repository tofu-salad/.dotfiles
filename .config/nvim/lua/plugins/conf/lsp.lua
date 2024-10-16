-- [[ Configure LSP ]]
-- Setup neovim lua configuration
require("neodev").setup()

local custom_format = function()
	if vim.bo.filetype == "templ" then
		local bufnr = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(bufnr)
		local cmd = "templ fmt " .. vim.fn.shellescape(filename)
		vim.fn.jobstart(cmd, {
			on_exit = function()
				-- Reload the buffer only if it's still the current buffer
				if vim.api.nvim_get_current_buf() == bufnr then
					vim.cmd("e!")
				end
			end,
		})
	else
		vim.cmd("Format")
	end
end
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil
	local nmap = function(keys, func, desc, options)
		if desc then
			desc = "LSP: " .. desc
		end

		options = options or {}
		options.buffer = bufnr
		vim.keymap.set("n", keys, func, options)
	end

	nmap("<leader>lr", vim.lsp.buf.rename, "[L]sp [R]ename")
	nmap("<leader>la", vim.lsp.buf.code_action, "[L]sp code [A]ction")
	nmap("<leader>lf", custom_format, "[L]sp custom [F]ormat", { remap = false })

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
end

local servers = {
	astro = {},
	cssls = {},
	svelte = {},
	clangd = {},
	gopls = {},
	pyright = {},
	ts_ls = {},
	rust_analyzer = {
		cachePriming = { enable = false },
	},
	nil_ls = {},
	templ = {},
	htmx = {
		filetypes = { "html", "templ" },
	},
	tailwindcss = {
		filetypes = {
			"aspnetcorerazor",
			"astro",
			"astro-markdown",
			"blade",
			"clojure",
			"django-html",
			"htmldjango",
			"edge",
			"eelixir",
			"elixir",
			"ejs",
			"erb",
			"eruby",
			"gohtml",
			"gohtmltmpl",
			"haml",
			"handlebars",
			"hbs",
			"html",
			"html-eex",
			"heex",
			"jade",
			"leaf",
			"liquid",
			"mdx",
			"mustache",
			"njk",
			"nunjucks",
			"php",
			"razor",
			"slim",
			"twig",
			"css",
			"less",
			"postcss",
			"sass",
			"scss",
			"stylus",
			"sugarss",
			"javascript",
			"javascriptreact",
			"reason",
			"rescript",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
			"templ",
			"gotmpl",
			"tmpl",
		},
		init_options = { userLanguages = { templ = "html" } },
	},
	html = {
		filetypes = { "html", "twig", "hbs", "templ", "gotmpl", "typescript" },
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				disable = { "missing-fields" },
				globals = { "vim" },
			},
		},
	},
}

local NixOS = require("core.utils").detect_nixos()
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

if NixOS then
	servers.html.cmd = { "vscode-html-language-server", "--stdio" }
	servers.cssls.cmd = { "vscode-css-language-server", "--stdio" }
	servers.ts_ls.cmd = { "typescript-language-server", "--stdio" }
	for server_name, server_config in pairs(servers) do
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = server_config,
			filetypes = (server_config or {}).filetypes,
			cmd = (server_config or {}).cmd,
		})
	end
else
	-- Ensure the servers above are installed
	local mason_lspconfig = require("mason-lspconfig")

	mason_lspconfig.setup_handlers({
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = (servers[server_name] or {}).settings,
				root_pattern = (servers[server_name] or {}).root_pattern,
				filetypes = (servers[server_name] or {}).filetypes,
				init_options = (servers[server_name] or {}).init_options,
			})
		end,
	})
end
