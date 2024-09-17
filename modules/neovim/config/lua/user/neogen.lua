local neogen = require("neogen")

neogen.setup({
  snippet_engine = "luasnip",
})

vim.keymap.set("n", "<leader>gco", neogen.generate, { noremap = true, silent = true })
