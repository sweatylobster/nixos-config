-- personal preferences
require("user.keymaps")
require("user.options")
require("user.autocommands")
require("cloak").setup()

-- UI
require("user.colorscheme")
require("nvim-web-devicons").setup()
require("user.notify")
require("user.lualine")

-- SO-CALLED "BASIC"
require("user.indent")
require("dressing").setup({
  input = {
	insert_only = false,
  },
})
require('user.telescope')
require('user.git')
require("auto-hlsearch").setup()


require("neodev").setup()  -- can't use lazydev without a lazy-loading package manager?
require("luasnip").setup({
  -- see: https://github.com/L3MON4D3/LuaSnip/issues/525
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})
require("luasnip.loaders.from_vscode").lazy_load()
require("user.oil")
require('nvim-surround').setup()
require("user.conform")
