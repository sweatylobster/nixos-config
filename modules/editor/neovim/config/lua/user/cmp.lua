local blink = require("blink.cmp")
-- local luasnip = require("luasnip")
-- local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

blink.setup({
  appearance = { nerd_font_variant = "mono" },
  cmdline = {
    enabled = true,
    sources = function()
      local type = vim.fn.getcmdtype()
      if type == "/" or type == "?" then
        return { "buffer" }
      elseif type == ":" then
        return { "cmdline" }
      end
      return {}
    end,
  },
  completion = {
    keyword = { range = "full" }, -- :h blink-cmp-config-completion | 1859
    -- TODO: Do I like auto_brackets?
    accept = { auto_brackets = { enabled = true } },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,
      treesitter_highlighting = true,
    },
    -- TODO: Do I like ghost_text?
    -- ghost_text = { enabled = true },
  },
  keymap = {
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    -- Override default 'cancel' binding; I prefer EOL.
    ["<C-e>"] = {
      function()
        require("blink.cmp")["hide"]()
        vim.cmd([[norm <C-e>]])
      end,
      "hide",
    },
    ["<C-space>"] = {
      ---@diagnostic disable-next-line: redefined-local
      function(cmp)
        cmp.show({ providers = { "snippets" } })
      end,
    },
  },
  signature = {
    enabled = true,
  },
  -- TODO: Set up a ~/.config/nvim/snippets directory with Nix.
  -- snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
