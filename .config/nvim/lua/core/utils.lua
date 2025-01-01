local M = {}

function M.detect_nixos()
	local file = io.open("/etc/nixos", "r")
	if file then
		file:close()
		return true
	else
		return false
	end
end

M.base16 = {
	oxocarbon = {
		dark = {
			base00 = "#161616",
			base01 = "#262626",
			base02 = "#393939",
			base03 = "#525252",
			base04 = "#DDE1E6",
			base05 = "#D0D0D0",
			base06 = "#FFFFFF",
			base07 = "#08BDBA",
			base08 = "#3DDBD9",
			base09 = "#78A9FF",
			base10 = "#EE5396",
			base11 = "#33B1FF",
			base12 = "#FF7EB6",
			base13 = "#42BE65",
			base14 = "#BE95FF",
			base15 = "#82CFFF",
			blend = "#131313",
			none = "NONE",
		},
		light = {
			base00 = "#FFFFFF",
			base01 = "#DDE1E6",
			base02 = "#525252",
			base03 = "#161616",
			base04 = "#37474F",
			base05 = "#90A4AE",
			base06 = "#525252",
			base07 = "#08BDBA",
			base08 = "#FF7EB6",
			base09 = "#EE5396",
			base10 = "#FF6F00",
			base11 = "#0F62FE",
			base12 = "#673AB7",
			base13 = "#42BE65",
			base14 = "#BE95FF",
			base15 = "#FFAB91",
			blend = "#FAFAFA",
			none = "NONE",
		},
	},
}

return M
