-- personal preferences
require("user.keymaps")
require("user.options")
require("user.autocommands")

-- UI
require("user.colorscheme")
require("nvim-web-devicons").setup()
require("user.notify")
require("user.lualine")

-- SO-CALLED "BASIC"
require("user.indent")
require('nvim-surround').setup()
require('user.telescope')

require("neodev").setup()  -- can't use lazydev without a lazy-loading package manager?
require("user.oil")
