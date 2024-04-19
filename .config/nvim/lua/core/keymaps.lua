local keymap = vim.keymap.set

vim.g.mapleader = " " -- Leader Key ( Space )
keymap("n", "<leader>d", '[["_d]]')
keymap("i", "jk", "<ESC>", { silent = true }) -- { desc = { "Better Esc" }
keymap("i", "jj", "<ESC>", { silent = true }) -- desc = { "Better Esc" },
keymap("v", "<leader>y", '"+y', { silent = true }) -- desc = { "Yank to System Clipboard" },
keymap("v", "<", "<gv", { silent = true }) --  desc = "Indent Left withoput leaving Visual mode",
keymap("v", ">", ">gv", { silent = true }) --  desc = "Indent Right without leaving Visual mode",
keymap("v", "J", ":m '>+1<CR>gv=gv") -- { desc = "Move Visual mode text up" }
keymap("v", "K", ":m '<-2<CR>gv=gv") --  { desc = "Move Visual mode text down" }
keymap("x", "<leader>p", '[["_dP')
keymap("n", "<leader>e", "<cmd> Explore <CR>") -- , { desc = "Open Netrw" }

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev) -- , { desc = "Go to previous diagnostic message" }
keymap("n", "]d", vim.diagnostic.goto_next) -- , { desc = "Go to next diagnostic message" }
keymap("n", "<leader>Q", vim.diagnostic.open_float) -- , { desc = "Open floating diagnostic message" }
keymap("n", "<leader>q", vim.diagnostic.setloclist) -- , { desc = "Open diagnostics list" }
