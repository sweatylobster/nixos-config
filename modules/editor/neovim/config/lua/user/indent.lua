require("ibl").setup({
  indent = { char = "|" },
  exclude = { filetypes = { "help" } },
  scope = { enabled = false },
})

-- require('treesj').setup()
local treesj = require("treesj")
treesj.setup()

vim.keymap.set("n", "<leader>gS", treesj.toggle, {
  noremap = true,
  silent = true,
  desc = "Toggle [s]plit/join",
})
