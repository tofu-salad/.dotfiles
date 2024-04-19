local oxocarbon_light = {
	base00 = "#ffffff",
	base01 = "#f2f2f2",
	base02 = "#d0d0d0",
	base03 = "#161616",
	base04 = "#37474F",
	base05 = "#90A4AE",
	base06 = "#525252",
	base07 = "#08bdba",
	base08 = "#ff7eb6",
	base09 = "#ee5396",
	base0A = "#FF6F00",
	base0B = "#0f62fe",
	base0C = "#673AB7",
	base0D = "#42be65",
	base0E = "#be95ff",
	base0F = "#FFAB91",
}
local oxocarbon_dark = {
	base00 = "#000000",
	base01 = "#262626",
	base02 = "#393939",
	base03 = "#525252",
	base04 = "#dde1e6",
	base05 = "#f2f4f8",
	base06 = "#ffffff",
	base07 = "#08bdba",
	base08 = "#3ddbd9",
	base09 = "#78a9ff",
	base0A = "#ee5396",
	base0B = "#33b1ff",
	base0C = "#ff7eb6",
	base0D = "#42be65",
	base0E = "#be95ff",
	base0F = "#82cfff",
}
-- All builtin colorschemes can be accessed with |:colorscheme|.
require("base16-colorscheme").with_config({
	telescope = false,
})
require("base16-colorscheme").setup(oxocarbon_dark)
-- Alternatively, you can provide a table specifying your colors to the setup function.
