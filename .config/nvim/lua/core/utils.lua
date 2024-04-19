local M = {}

function M.detect_nixos()
	local file = io.open("/etc/nixos", "r") -- Check if a file indicative of NixOS exists
	if file then
		file:close()
		return true -- File found, indicating NixOS
	else
		return false -- File not found, probably not NixOS
	end
end

return M
