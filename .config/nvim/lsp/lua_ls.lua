local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = root_files,
	settings = {
		Lua = {
			workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}
