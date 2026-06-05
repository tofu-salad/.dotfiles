return {
	cmd = function(dispatchers, config)
		local cmd = "oxfmt"
		if (config or {}).root_dir then
			local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
			if vim.fn.executable(local_cmd) == 1 then
				cmd = local_cmd
			end
		end
		return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"toml",
		"json",
		"jsonc",
		"json5",
		"yaml",
		"html",
		"vue",
		"handlebars",
		"css",
		"scss",
		"less",
		"graphql",
		"markdown",
	},
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local path = vim.fn.fnamemodify(fname, ":h")

		local root_markers = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }

		local pkg_files = vim.fs.find(
			{ "package.json", "package.json5" },
			{ path = path, upward = true, type = "file" }
		)
		for _, f in ipairs(pkg_files) do
			local file = io.open(f, "r")
			if file then
				for line in file:lines() do
					if line:find("oxfmt") or line:find("vite%-plus") then
						root_markers[#root_markers + 1] = vim.fs.basename(f)
						break
					end
				end
				file:close()
			end
		end

		local vite_files = vim.fs.find({ "vite.config.ts" }, { path = path, upward = true, type = "file" })
		for _, f in ipairs(vite_files) do
			local file = io.open(f, "r")
			if file then
				local found_vite_plus, found_fmt = false, false
				for line in file:lines() do
					if line:find("vite%-plus") then
						found_vite_plus = true
					end
					if line:find("fmt:") then
						found_fmt = true
					end
					if found_vite_plus and found_fmt then
						root_markers[#root_markers + 1] = "vite.config.ts"
						break
					end
				end
				file:close()
			end
		end

		on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
	end,
}
