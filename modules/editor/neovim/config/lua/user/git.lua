vim.g.fugitive_legacy_commands = 0

vim.keymap.set("n", "<leader>gs", vim.cmd.Git, {
  noremap = true,
  silent = true,
  desc = "Open Git",
})

vim.keymap.set("n", "<leader>gms", function()
  vim.cmd.Git("sync")
end, {
  noremap = true,
  silent = true,
  desc = "Git sync",
})

require("gitsigns").setup({
  preview_config = {
    border = "rounded",
  },
})

vim.keymap.set("n", "<leader>gp", function()
  vim.cmd.Gitsigns("preview_hunk")
end, {
  noremap = true,
  silent = true,
  desc = "Git preview hunk",
})

vim.keymap.set("n", "]g", function()
  require("gitsigns").nav_hunk("next", { wrap = false, preview = true })
end, {
  noremap = true,
  silent = true,
  desc = "gitsigns next hunk",
})

vim.keymap.set("n", "[g", function()
  require("gitsigns").nav_hunk("prev", { wrap = false, preview = true })
end, {
  noremap = true,
  silent = true,
  desc = "gitsigns next hunk",
})
