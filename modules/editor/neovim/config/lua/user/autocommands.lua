local function augroup(name, opts)
  return vim.api.nvim_create_augroup(name, opts)
end

-- Disable line numbers (and spell) in terminal mode
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup("terminal", { clear = false }),
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
    vim.cmd("startinsert")
    vim.cmd("setlocal nospell")
  end,
})

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
  pattern = "*",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "startinsert",
  group = vim.api.nvim_create_augroup("AutoInsert", { clear = true }),
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.wincmd("L")
    end
  end,
})
