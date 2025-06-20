-- personal preferences
require("user.keymaps")
require("user.options")
require("user.autocommands")
require("user.cloak")

-- UI
require("user.colorscheme")
require("nvim-web-devicons").setup()
require("user.notify")
require("user.lualine")

-- SO-CALLED "BASIC"
require("user.indent")
require("user.todo")
require("dressing").setup({
  input = {
    insert_only = false,
  },
})
require("user.telescope")
require("user.git")
require("auto-hlsearch").setup()
require("user.flash")

-- PERSONAL
require("user.vimtex")
require("user.markdown-preview")
require("user.firenvim")

require("neodev").setup() -- can't use lazydev without a lazy-loading package manager?
require("luasnip").setup({
  -- see: https://github.com/L3MON4D3/LuaSnip/issues/525
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})
require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-autopairs").setup({ check_ts = true })
require("nvim-ts-autotag").setup({ enable = true })
require("user.oil")
require("user.yazi")
require("user.lsp")
require("user.cmp")
require("nvim-surround").setup()
require("user.treesitter")
require("user.conform")
require("user.neogen")
require("typst-preview").setup({
  dependencies_bin = {
    tinymist = string.format("/etc/profiles/per-user/%s/bin/tinymist", os.getenv("USER")),
    websocat = string.format("/etc/profiles/per-user/%s/bin/websocat", os.getenv("USER")),
  },
})
