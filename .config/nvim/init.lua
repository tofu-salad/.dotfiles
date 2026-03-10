-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.cursorline = true
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.laststatus = 3
vim.o.mouse = "a"

vim.o.colorcolumn = "80"
vim.o.signcolumn = "yes"

vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.hlsearch = false
vim.o.inccommand = "split"
vim.o.incsearch = true

vim.o.swapfile = false
vim.o.undofile = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.completeopt = "menu,noselect,fuzzy,nosort"
vim.o.timeoutlen = 300
vim.o.updatetime = 250

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_keepdir = 1

-- commands
vim.api.nvim_create_user_command('LspInfo', function()
	vim.cmd('checkhealth vim.lsp')
end, {})

vim.api.nvim_create_user_command('FindCwd', function(opts)
	local input = opts.args
	if input == '' then return end
	local cwd = vim.fn.getcwd() .. '/'
	vim.cmd('edit ' .. vim.fn.fnameescape(cwd .. input))
end, {
	nargs = 1,
	complete = function(arglead)
		local cwd = vim.fn.getcwd() .. '/'
		local matches = vim.fn.systemlist('fd --type f --max-results 20 --glob ' ..
			vim.fn.shellescape('*' .. arglead .. '*') .. ' ' .. vim.fn.shellescape(cwd))
		return vim.tbl_map(function(f)
			return f:gsub('^' .. vim.pesc(cwd), '')
		end, matches)
	end,
})

vim.api.nvim_create_user_command('FindGit', function(opts)
	local input = opts.args
	if input == '' then return end

	local files = vim.fn.systemlist('git ls-files')
	local matches = vim.tbl_filter(function(f)
		return f:find(input, 1, true) ~= nil
	end, files)

	if #matches == 0 then
		vim.notify('No files found: ' .. input, vim.log.levels.WARN)
	else
		vim.cmd('edit ' .. vim.fn.fnameescape(matches[1]))
	end
end, {
	nargs = 1,
	complete = function(arglead)
		local files = vim.fn.systemlist('git ls-files')
		return vim.tbl_filter(function(f)
			return f:find(arglead, 1, true) ~= nil
		end, files)
	end,
})

-- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "[y]ank to system clipbloard" })
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "indent left without leaving visual mode [<]" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "indent right without leaving visual mode [>]" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move text up in visual mode [J]" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move text down in visual mode [K]" })
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "open netrw" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up (centered)" })

vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "go to next quicklist item ']q'" })
vim.keymap.set("n", "[q", ":cprevious<CR>", { desc = "go to previous quicklist item '[q'" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "go to previos diagnostic message '[d'" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "go to next diagnostic message ']d'" })
vim.keymap.set("n", "<leader>Q", vim.diagnostic.open_float, { desc = "open floating diagnostic [Q]" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "move focus to the upper window" })


vim.keymap.set('n', '<leader>ff', ':FindCwd ', { desc = "[f]ind [f]iles" })
vim.keymap.set('n', '<leader>ft', ':FindGit ', { desc = '[f]ind gi[t] files' })
vim.keymap.set('n', '<leader>fg', function()
	vim.ui.input({ prompt = 'Grep > ' }, function(input)
		if not input or input == '' then return end
		vim.cmd('silent grep ' .. input)
		vim.cmd('copen')
	end)
end, { desc = '[f]iles [g]rep' })

-- autocmds

-- [[ highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 50 })
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ vertical help ]]
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L"
})

-- [[ auto resize splits ]]
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd ="
})

-- lsp
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	jump = { float = true },
})

local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local all_files = vim.fn.readdir(lsp_dir)

local files = {}
for _, file in ipairs(all_files) do
	if file:match("%.lua$") then
		table.insert(files, file)
	end
end

local servers = {}
for _, file in ipairs(files) do
	local name = file:match("(.+)%.lua$")
	if name then
		table.insert(servers, name)
	end
end
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end

		-- keybinds
		map("<leader>lr", vim.lsp.buf.rename, "[l]sp [r]ename")
		map("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
		map("<leader>la", vim.lsp.buf.code_action, "[l]sp code [a]ction")

		map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
		map("<leader>gr", vim.lsp.buf.references, "[g]oto [r]eferences")
		map("gI", vim.lsp.buf.implementation, "[g]oto [I]mplementation")
		map("<leader>D", vim.lsp.buf.type_definition, "type [D]efinition")
		map("<leader>ds", vim.lsp.buf.document_symbol, "[d]ocument [s]ymbols")
		map("<leader>ws", vim.lsp.buf.workspace_symbol, "[w]orkspace [s]ymbols")

		-- see `:help K` for why this keymap
		map("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "hover documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "signature documentation")

		-- lesser used lsp functionality
		map("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")
		map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd folder")
		map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove folder")
		map("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[w]orkspace [l]ist folders")
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\npress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"jesseleite/noirbuddy.nvim",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" }
		},
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			local ignore_parsers = {
				jsonc = true,
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(ctx)
					local ft = ctx.match
					if not ft or ft == "" then
						return
					end

					local lang = vim.treesitter.language.get_lang(ft)
					if not lang or ignore_parsers[lang] then
						return
					end

					local available_parsers = ts.get_available()
					if not vim.tbl_contains(available_parsers, lang) then
						return
					end

					local installed = ts.get_installed("parsers")
					if not vim.tbl_contains(installed, lang) then
						ts.install({ lang })
						return
					end

					pcall(vim.treesitter.start, ctx.buf)
					vim.bo[ctx.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
				end,
			})
		end,
	},
})
