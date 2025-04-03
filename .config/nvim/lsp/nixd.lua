return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "nixfmt" },
			},
			options = {
				nixos = {
					expr = '(builtins.getFlake "'
						.. vim.loop.os_homedir()
						.. '/.config/nixos").nixosConfigurations.desktop.options',
				},
			},
		},
	},
}
