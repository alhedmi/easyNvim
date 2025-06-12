local M = {}

local keymap = vim.keymap

-- Define a helper to simplify setting keymaps with descriptions
local function map(mode, lhs, rhs, desc)
  keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Safe fallback keymaps that always load
map("n", "<C-s>", ":w<CR>", "Save File")
map("i", "<C-s>", "<Esc>:w<CR>a", "Save File")
map("n", "<leader>q", ":q<CR>", "Quit")
map("n", "<C-h>", "<C-w>h", "Move to Left Window")
map("n", "<C-l>", "<C-w>l", "Move to Right Window")
map("n", "<C-j>", "<C-w>j", "Move to Lower Window")
map("n", "<C-k>", "<C-w>k", "Move to Upper Window")

-- LSP-like bindings
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Show References")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover Docs")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action")

-- Telescope basic mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Find Files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live Grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "List Buffers")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help Tags")

-- Nvim Tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", "Toggle File Tree")

-- ToggleTerm
map("n", "<leader>tt", ":ToggleTerm<CR>", "Toggle Terminal")

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
