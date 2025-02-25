local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Edit non-existent paths.
keymap("", "gf", ":edit <cfile><CR>")
keymap("", "gt", ":tabedit <cfile><CR>")

-- Get into normal mode in the terminal. Often easier than tmux copy-mode.
keymap("t", "<esc><esc>", "<C-\\><C-n>")

-- MOVEMENTS
--

-- quickfix movements.
keymap("n", "<leader>co", ":copen<CR>", opts)
keymap("n", "<leader>cc", ":cclose<CR>", opts)
keymap("n", "]c", ":cnext<CR>zz", opts)
keymap("n", "[c", ":cprev<CR>zz", opts)

-- tab movements.
keymap("n", "<leader><tab><tab>", vim.cmd.tabnew, opts)
keymap("n", "<leader><tab>]", vim.cmd.tabnext, opts)
keymap("n", "<leader><tab>[", vim.cmd.tabprev, opts)
keymap("n", "<leader><tab>q", vim.cmd.tabclose, opts)

-- buf movements.
keymap("n", "]b", ":bnext<CR>", opts)
keymap("n", "[b", ":bprev<CR>", opts)
keymap("n", "<leader>q", ":bdelete<CR>", opts)

keymap({ "n", "x", "o" }, "gh", "^")
keymap({ "n", "x", "o" }, "gl", "$")

-- REGISTERS
--

-- repeatably replace text.
keymap("n", "<leader>p", '"_dp', opts)

-- yank current path.
keymap("n", "<leader>py", ':let @" = expand("%:p")<CR>')

-- yank to clipboard.
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap({ "n", "v" }, "<leader>Y", '"+Y', opts)

-- delete to blackhole.
keymap({ "n", "v" }, "<leader>d", '"_d', opts)
keymap({ "n", "v" }, "<leader>D", '"_D', opts)

-- POSITIONING
--

-- center search result.
keymap("n", "<leader>n", "nzzzv", opts)
keymap("n", "<leader>N", "Nzzzv", opts)

-- stay put when joining.
keymap("n", "J", "mzJ`z", opts)

-- center page scrolling.
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- resize with arrows.
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- insert an empty blank line above, or below.
keymap("n", "]<Space>", "m`o<Esc>``", opts)
keymap("n", "[<Space>", "m`O<Esc>``", opts)

-- PRIMEAGEN BUFFER UTILS
--

-- replace the word under the cursor for the whole buffer.
keymap("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

-- give buffer executable permissions.
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

-- JUNEGUNN
--
keymap({ "n", "x" }, "ga", "<Plug>(EasyAlign)")

-- INSERT MODE
--

-- add undo points after punctuation.
keymap("i", "-", "-<c-g>u", opts)
keymap("i", "_", "_<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", ",", ",<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)

-- VISUAL MODE
--

-- pasting over visually-selected text does not overwrite the clipboard.
keymap("v", "p", '"_dP', opts)

-- stay in visual mode when indenting. (using `.` is absurd.)
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
