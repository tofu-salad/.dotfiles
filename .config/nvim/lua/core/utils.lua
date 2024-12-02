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

return M
