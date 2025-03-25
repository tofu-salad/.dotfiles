vim.opt.laststatus = 3

function _G.get_git_branch()
	local current_dir = vim.fn.expand("%:p:h")
	local git_dir = vim.fn.finddir(".git", current_dir .. ";")

	if git_dir ~= "" then
		local branch = vim.fn.system("git -C " .. current_dir .. " branch --show-current 2>/dev/null"):gsub("\n", "")
		return branch ~= "" and "[" .. branch .. "]" or ""
	end

	return ""
end

vim.opt.statusline = table.concat({
	"%{v:lua.get_git_branch()}", -- git branch
	"%=",
	"%<%f", -- File path (truncated from left if too long)
	"%m", -- Modified flag
	"%r", -- Read-only flag
	"%h", -- Help buffer flag
	"%w", -- Preview window flag
	"%=", -- Separator between left and right aligned items
	"%l/%L", -- Current line/Total lines
	":%c", -- Column number
	" ",
	"%P", -- Percentage through file
})
function G.get_git_branch()
    local current_dir = vim.fn.expand("%:p:h")
    local git_dir = vim.fn.finddir(".git", current_dir .. ";")
    
    if git_dir ~= "" then
        local branch = vim.fn.system("git -C " .. current_dir .. " branch --show-current 2>/dev/null"):gsub("\n", "")
        
        if branch ~= "" then
            local status = vim.fn.system("git -C " .. current_dir .. " status 2>&1")
            local bits = ""
            
            -- Check for various git status conditions
            if status:match("renamed:") then
                bits = ">" .. bits
            end
            
            if status:match("Your branch is ahead of") then
                bits = "*" .. bits
            end
            
            if status:match("new file:") then
                bits = "+" .. bits
            end
            
            if status:match("Untracked files") then
                bits = "?" .. bits
            end
            
            if status:match("deleted:") then
                bits = "x" .. bits
            end
            
            if status:match("modified:") then
                bits = "*" .. bits
            end
            
            -- Return branch with status indicators
            return bits ~= "" and "‹" .. branch .. bits .. "›" or "‹" .. branch .. "›"
        end
    end
    
    return ""
end

-- Update statusline to use the new function
vim.opt.statusline = table.concat({
    "%{v:lua.get_git_branch()}", -- Git branch with status
    "%=",
    "%<%f", -- File path (truncated from left if too long)
    "%m", -- Modified flag
    "%r", -- Read-only flag
    "%h", -- Help buffer flag
    "%w", -- Preview window flag
    "%=", -- Separator between left and right aligned items
    "%l/%L", -- Current line/Total lines
    ":%c", -- Column number
    " ",
    "%P", -- Percentage through file
})
