local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    json = { "jq" },
    lua = { "stylua" },
    markdown = { "prettier" },
    nix = { "nixpkgs_fmt" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    sql = { "pg_format", "sql_formatter" },
    yaml = { "prettier" },
    zig = { "zigfmt" },
    ["_"] = { "trim_whitespace", "trim_newlines" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
