local M = {}

function M.detect_nixos()
	local file = io.open("/etc/os-release", "r")
	if file then
		local content = file:read("*all")
		file:close()
		if content:match("ID=nixos") then
			return true
		end
	end
	return false
end

return M
