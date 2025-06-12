-- lua/amir/lsp.lua
local config = require("amir.config")

-- Setup Mason (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "clangd" },
})

-- Setup LSP servers
local lspconfig = require("lspconfig")

-- Common on_attach for LSP clients
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

-- Capabilities for nvim-cmp integration
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup Pyright
lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Setup Clangd
lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Autocompletion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- Optional: Signature help
if config.enable_signature_help then
  require("lsp_signature").setup({})
end

-- Optional: LSP UI enhancement (Lspsaga)
if config.enable_lspsaga then
  require("lspsaga").setup({})
end
