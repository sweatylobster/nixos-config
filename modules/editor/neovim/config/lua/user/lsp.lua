-- Make runtime files discoverable to `lua_ls`
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local keymaps = require("lsp_keymaps")
require("lsp_autocommands").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities({
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true, -- needs fswatch on linux
      relativePatternSupport = true,
    },
  },
}, true)

---@diagnostic disable: unused-local
local on_attach = function(client, bufnr)
  keymaps.on_attach(bufnr)
end

local function mkLSP(name, filetypes, settings)
  return { name = name, filetypes = filetypes, settings = settings, }
end

local SERVERS = {
  mkLSP("bashls", { "sh", "bash" }, {}),
  mkLSP("clangd", { "c" }, {}),
  mkLSP("html", { "htm", "html", "templ" }, {}),
  mkLSP("htmx", { "html", "templ" }, {}),
  mkLSP("jqls", { "jq" }, {}),
  mkLSP("lua_ls", { "lua" },
    { Lua = { completion = { callSnippet = "Replace", }, telemetry = { enable = false }, hint = { enable = true, }, }, }),
  mkLSP("nil_ls", { "nix" }, {}),
  mkLSP("ols", { "odin" }, {}),
  mkLSP("pylsp", { "py" }, { pylsp = { plugins = { ruff = { enabled = true } }, }, }),
  mkLSP("pyright", { "py" }, {}),
  mkLSP("rust_analyzer", { "rs" }, {}),
  mkLSP("tinymist", { "typ", "typst" }, { formatterMode = "typstyle", exportPdf = "onType", semanticTokens = "disable", }),
}

for i, lsp in ipairs(SERVERS) do
  -- print(i, lsp.name, vim.inspect(lsp.filetypes), vim.inspect(lsp.settings))
  -- mkConfig(lsp.name, lsp.filetypes, lsp.settings)
  vim.lsp.config(lsp.name, {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = lsp.filetypes,
    settings = lsp.settings,
  })
  vim.lsp.enable(lsp.name)
end

local function get_float_config()
  return {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  }
end

local function get_diagnostic_config(float_config)
  return {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
    float = float_config,
  }
end

local fx = get_float_config()
local dx = get_diagnostic_config(fx)

vim.diagnostic.config(dx)

vim.lsp.buf.hover(fx)
vim.lsp.buf.signature_help(fx)
vim.hl.priorities.semantic_tokens = 95
