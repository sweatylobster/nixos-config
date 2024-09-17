local notify = require("notify")

notify.setup({
  render = "compact",
  stages = "static",
  timeout = 2000,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
  on_open = function(win)
    vim.api.nvim_win_set_config(win, { focusable = false }) -- i like getting output with print sometimes
  end,
})
vim.notify = notify

vim.keymap.set("n", "<leader>nd", function()
  notify.dismiss({ silent = true, pending = true })
end, {
  noremap = true,
  silent = true,
  desc = "Get rid of notifications",
})
