require("oil").setup()

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "-", ":Oil <CR>", opts)
vim.keymap.set("n", "<leader>-", function() require('oil').toggle_float() end, opts)
