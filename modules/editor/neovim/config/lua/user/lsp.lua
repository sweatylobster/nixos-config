local ms = require("vim.lsp.protocol").Methods
local cmp_capabilities = require("blink.cmp").get_lsp_capabilities()
local keymaps = require("lsp_keymaps")
require("lsp_autocommands").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, cmp_capabilities)
capabilities = vim.tbl_deep_extend("force", capabilities, {
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true, -- needs fswatch on linux
      relativePatternSupport = true,
    },
  },
})

---@param client vim.lsp.Client LSP client
---@param bufnr number Buffer number
---@diagnostic disable: unused-local
local on_attach = function(client, bufnr)
  keymaps.on_attach(bufnr)
end

local lspconfig = require("lspconfig")
require("lspconfig.ui.windows").default_options.border = "rounded"
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

for _, lsp in ipairs({
  "bashls",
  "clangd",
  "cssls",
  "dockerls",
  "jsonls",
  "nil_ls",
  "rust_analyzer",
  "taplo",
  "templ",
  "terraformls",
  "tflint",
  "zls",
}) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

for _, lsp in ipairs({ "html", "htmx" }) do
  lspconfig[lsp].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "templ" },
  })
end

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "html", "templ", "javascript" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
    },
  },
})

lspconfig.tinymist.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "typst" },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable",
  },
})

lspconfig.yamlls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemaStore = {
        url = "https://www.schemastore.org/api/json/catalog.json",
        enable = true,
      },
    },
  },
})

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
      hint = {
        enable = true,
      },
    },
  },
})

lspconfig.pylsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = { ruff = { enabled = true } },
    },
  },
})

local float_config = {
  focusable = true,
  style = "minimal",
  border = "rounded",
  source = "always",
  header = "",
  prefix = "",
}

-- setup diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = false, --{ spacing = 4, prefix = "●" },
  severity_sort = true,
  float = float_config,
})

vim.lsp.handlers[ms.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, float_config)
vim.lsp.handlers[ms.textDocument_signatureHelp] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)
vim.highlight.priorities.semantic_tokens = 95

-- set up diagnostic signs
for name, icon in pairs(require("user.icons").diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
