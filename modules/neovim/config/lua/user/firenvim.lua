if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0
else
  vim.o.laststatus = 2
end

vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      content = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never",
    },
    ["https?://practice.conexem"] = {
      takeover = "always",
      priority = 1,
    },
  },
}

local function getFirenvimPath()
  local path = vim.system({ "fd", "firenvim", "-td", "/private/var/folders/kt/" }, { text = true }):wait().stdout
  return path
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>fro", function()
  local path = getFirenvimPath()
  vim.cmd(":Oil " .. path)
end, {})
