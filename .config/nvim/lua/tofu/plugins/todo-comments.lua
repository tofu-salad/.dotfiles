local pack = require("tofu.pack")

pack.add_gh("folke/todo-comments.nvim")
require("todo-comments").setup({ signs = false })
