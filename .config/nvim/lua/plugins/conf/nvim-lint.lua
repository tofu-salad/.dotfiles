local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	javascriptreact = { "eslint" },
	typescriptreact = { "eslint" },
	svelte = { "eslint" },
	go = { "golangcilint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint(nil, { ignore_errors = true })
	end,
})

local function show_linter_info()
	local filetype = vim.bo.filetype
	local registered_linters = lint.linters_by_ft[filetype] or {}

	local lines = { "Linter Information for filetype: " .. filetype }

	if #registered_linters == 0 then
		table.insert(lines, "No linters configured for this filetype")
	else
		table.insert(lines, "Configured linters:")
		for _, linter in ipairs(registered_linters) do
			local executable_name = linter
			if linter == "golangcilint" then
				executable_name = "golangci-lint"
			end

			local linter_available = vim.fn.executable(executable_name) == 1
			local status = linter_available and "✓ Available" or "✗ Not found"
			table.insert(lines, "- " .. linter .. " (" .. status .. ")")
		end
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	local width = vim.api.nvim_get_option("columns")
	local height = vim.api.nvim_get_option("lines")

	local win_width = math.min(60, math.ceil(width * 0.5))
	local win_height = math.min(#lines + 2, math.ceil(height * 0.3))
	local row = math.ceil((height - win_height) / 2)
	local col = math.ceil((width - win_width) / 2)

	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
		title = " Linter Status ",
		title_pos = "center",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { silent = true, noremap = true })
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { silent = true, noremap = true })

	vim.api.nvim_set_current_win(win)
end

vim.api.nvim_create_user_command("LinterInfo", show_linter_info, {})
