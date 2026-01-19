-- options
vim.g.have_nerd_font = false
vim.o.mouse = "a"

vim.o.hlsearch = false
vim.o.inccommand = "split"
vim.o.incsearch = true

vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.wrap = false

vim.o.colorcolumn = "80"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

vim.o.timeoutlen = 300
vim.o.updatetime = 250

vim.o.swapfile = false
vim.o.undofile = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.laststatus = 3
vim.opt.completeopt:append("noselect")
-- keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "[y]ank to system clipbloard" })
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "indent left without leaving visual mode [<]" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "indent right without leaving visual mode [>]" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move text up in visual mode [J]" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move text down in visual mode [K]" })
vim.keymap.set("n", "<leader>d", '[["_d]]')
vim.keymap.set("x", "<leader>p", '[["_dP')
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "open netrw" })
vim.keymap.set("n", "]q", "<Cmd>cn<CR>", { desc = "go to next quicklist item ']q'" })
vim.keymap.set("n", "[q", "<Cmd>cp<CR>", { desc = "go to previous quicklist item '[q'" })
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

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_keepdir = 1

-- lsp
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
		map("<leader>la", vim.lsp.buf.code_action, "[l]sp code [a]ction")

		map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
		map("<leader>gr", function()
			require("mini.extra").pickers.lsp({ scope = "references" })
		end, "[g]oto [r]eferences")
		map("gI", vim.lsp.buf.implementation, "[g]oto [I]mplementation")
		map("<leader>D", vim.lsp.buf.type_definition, "type [D]efinition")
		map("<leader>ds", function()
			require("mini.extra").pickers.lsp({ scope = "document_symbol" })
		end, "[d]ocument [s]ymbols")
		map("<leader>ws", function()
			require("mini.extra").pickers.lsp({ scope = "workspace_symbol" })
		end, "[w]orkspace [s]ymbols")

		-- see `:help K` for why this keymap
		map("K", vim.lsp.buf.hover, "hover documentation")
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

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\npress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ spec = { { import = "plugins" } } })
require("filetypes")
