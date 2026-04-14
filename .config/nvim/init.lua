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

-- treat underscore as word separator
vim.opt.iskeyword:remove("_")

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_keepdir = 1

-- commands
vim.api.nvim_create_user_command("LspInfo", function()
	vim.cmd("checkhealth vim.lsp")
end, {})

-- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("v", "<leader>y", "\"+y", { silent = true, desc = "[y]ank to system clipbloard" })
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "indent left without leaving visual mode [<]" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "indent right without leaving visual mode [>]" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move text up in visual mode [J]" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move text down in visual mode [K]" })
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "open netrw" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up (centered)" })

vim.keymap.set("n", "q<Esc>", ":cclose<CR>", { desc = "close quicklist 'q<Esc>'" })
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

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>", { desc = "[f]ind [f]iles" })
vim.keymap.set("n", "<leader>ft", ":Pick files tool=\"git\"<CR>", { desc = "[f]ind gi[t] files" })
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>", { desc = "[f]iles [g]rep" })

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
	command = "wincmd L",
})

-- [[ auto resize splits ]]
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
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
		map("grf", vim.lsp.buf.format, "[l]sp [f]ormat")
		map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
		map("gws", vim.lsp.buf.workspace_symbol, "[w]orkspace [s]ymbols")

		-- see `:help K` for why this keymap
		map("K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, "hover documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "signature documentation")

		-- lesser used lsp functionality
		map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
	end,
})

vim.pack.add({
	{ src = "https://github.com/oskarnurm/koda.nvim" },
	{ src = "https://github.com/nvim-mini/mini.pick", version = "stable" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
})

require("koda").setup({
	colors = {
		bg = "#161616",
	},
})

vim.cmd("colorscheme koda")

require("mini.pick").setup()
require("fidget").setup({})

require "filetypes"
