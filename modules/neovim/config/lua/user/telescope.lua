local telescope = require("telescope")
local actions = require("telescope.actions")

local select_one_or_multi = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require("telescope.actions").close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format("%s %s", "edit", j.path))
      end
    end
  else
    actions.select_default(prompt_bufnr)
  end
end

-- just gonna copy caarlos0 again
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = select_one_or_multi,
        ["<C-y>"] = select_one_or_multi,
        ["<C-h>"] = actions.move_to_top,
        -- ["<C-m>"] = actions.move_to_middle,
        ["<C-l>"] = actions.move_to_bottom,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
    prompt_prefix = "   ",
    selection_caret = " ❯ ",
    entry_prefix = "   ",
    multi_icon = "+ ",
    path_display = { "filename_first" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git",
    },
  },
})

-- telescope.load_extension("zoxide")

local opts = { noremap = true, silent = true }

local builtin = require("telescope.builtin")

-- Open Telescope :) -- maybe not the right place
vim.keymap.set("n", "<leader>t", ":Telescope <CR>", opts)
vim.keymap.set("n", "<leader>sg", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>sf", builtin.find_files, opts)
vim.keymap.set("n", "<leader>gf", builtin.git_files, opts)
-- vim.keymap.set("n", "<leader>so", builtin.old_files, opts)
vim.keymap.set("n", "<leader><leader>", builtin.buffers, opts)
vim.keymap.set("n", "<leader>sh", builtin.help_tags, opts)
vim.keymap.set("n", "<leader>sc", builtin.commands, opts)
-- vim.keymap.set("n", "<leader>sc", builtin.commands, opts)
