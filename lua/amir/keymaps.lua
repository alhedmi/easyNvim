-- lua/amir/keymaps.lua
local M = {}

local keymap = vim.keymap

-- Helper function for keymaps with desc
local function map(mode, lhs, rhs, desc)
  keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 🧷 Core Keymaps (Not registered in which-key)
map("n", "<C-s>", ":w<CR>", "Save File")
map("i", "<C-s>", "<Esc>:w<CR>a", "Save File")
map("n", "<C-h>", "<C-w>h", "Move to Left Window")
map("n", "<C-l>", "<C-w>l", "Move to Right Window")
map("n", "<C-j>", "<C-w>j", "Move to Lower Window")
map("n", "<C-k>", "<C-w>k", "Move to Upper Window")

-- 🧠 LSP Essentials (Not grouped under <leader>)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Show References")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover Docs")

-- 🧭 Optional registration with which-key
function M.register_with_which_key()
  local config = require("amir.config")
  if not config.enable_which_key then return end

  local wk = require("which-key")
  wk.setup({})

  wk.register({
    ["<leader>"] = {
      e = { ":NvimTreeToggle<CR>", "Toggle File Tree" },
      q = { ":q<CR>", "Quit" },

      f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
        g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
        b = { "<cmd>Telescope buffers<cr>", "List Buffers" },
        h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
      },

      t = {
        name = "Terminal",
        t = { ":ToggleTerm<CR>", "Toggle Terminal" },
      },

      r = {
        name = "Refactor",
        n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
      },

      c = {
        name = "Code",
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      },
    },

    ["<C-s>"] = { ":w<CR>", "Save File" },
    ["<C-h>"] = { "<C-w>h", "Window Left" },
    ["<C-l>"] = { "<C-w>l", "Window Right" },
    ["<C-j>"] = { "<C-w>j", "Window Down" },
    ["<C-k>"] = { "<C-w>k", "Window Up" },

    gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
    gr = { "<cmd>lua vim.lsp.buf.references()<CR>", "Show References" },
    gi = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
    K  = { "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP Hover Docs" },
  })
end

return M
