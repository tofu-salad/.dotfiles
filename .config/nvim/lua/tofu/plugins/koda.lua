local pack = require("tofu.pack")

pack.add_gh("oskarnurm/koda.nvim")

require("koda").setup({})
vim.cmd.colorscheme("koda")
