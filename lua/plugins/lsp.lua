require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "clangd",
    "jdtls",
    "ts_ls",
    "jsonls",
    "sqlls",
  },
})

local capabilities =
  require("cmp_nvim_lsp").default_capabilities()

-- diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },

      workspace = {
        checkThirdParty = false,
      },

      telemetry = {
        enable = false,
      },
    },
  },
})

-- rust
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
})

-- c/c++
vim.lsp.config("clangd", {
  capabilities = capabilities,
})

-- js/ts
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

-- json
vim.lsp.config("jsonls", {
  capabilities = capabilities,
})

-- sql
vim.lsp.config("sqlls", {
  capabilities = capabilities,
})

-- java
vim.lsp.config("jdtls", {
  capabilities = capabilities,
})

-- enable servers
vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "clangd",
  "ts_ls",
  "jsonls",
  "sqlls",
  "jdtls",
})
