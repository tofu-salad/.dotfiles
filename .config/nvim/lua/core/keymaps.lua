vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.g.mapleader = " " -- Leader Key ( Space )
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "[y]ank to system clipbloard" })
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "indent left without leaving visual mode [<]" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "indent right without leaving visual mode [>]" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move text up in visual mode [J]" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move text down in viaul mode [K]" })
vim.keymap.set("n", "<leader>d", '[["_d]]')
vim.keymap.set("x", "<leader>p", '[["_dP')
vim.keymap.set("n", "<leader>e", "<cmd> Explore <CR>", { desc = "open netrw" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to previos diagnostic message '[d'" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next diagnostic message ']d'" })
vim.keymap.set("n", "<leader>Q", vim.diagnostic.open_float, { desc = "open floating diagnostic [Q]" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })

-- keybinds to make split navigation easier.
--  use CTRL+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "move focus to the upper window" })
