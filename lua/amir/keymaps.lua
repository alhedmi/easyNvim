local M = {}

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Safe fallback keymaps that always load
keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)

-- LSP-like bindings
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- Telescope basic mappings
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- Nvim Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

-- ToggleTerm
keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", opts)

-- Optional registration with which-key
function M.register_with_which_key()
  local config = require("amir.config")
  if not config.enable_which_key then return end
  local wk = require("which-key")
  wk.setup({})
  wk.register({
    ["<leader>"] = {
      e = { ":NvimTreeToggle<CR>", "Toggle File Tree" },
      ff = { "<cmd>Telescope find_files<cr>", "Find Files" },
      fg = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      fb = { "<cmd>Telescope buffers<cr>", "List Buffers" },
      fh = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
      tt = { ":ToggleTerm<CR>", "Toggle Terminal" },
      rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
      ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      q  = { ":q<CR>", "Quit" },
    },
    ["<C-s>"] = { "Save File" },
    ["<C-h>"] = { "Window Left" },
    ["<C-l>"] = { "Window Right" },
    ["<C-j>"] = { "Window Down" },
    ["<C-k>"] = { "Window Up" },
    gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
    gr = { "<cmd>lua vim.lsp.buf.references()<CR>", "Show References" },
    gi = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
    K =  { "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover Docs" },
  })
end

return M
