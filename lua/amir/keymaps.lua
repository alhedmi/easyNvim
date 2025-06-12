-- lua/amir/keymaps.lua

local M = {}

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 🔒 Core Keymaps (safe to always define)
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File", unpack(opts) })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File", unpack(opts) })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window", unpack(opts) })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window", unpack(opts) })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Lower Window", unpack(opts) })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Upper Window", unpack(opts) })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit", unpack(opts) })

-- 📚 LSP bindings
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition", unpack(opts) })
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Show References", unpack(opts) })
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to Implementation", unpack(opts) })
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "LSP Hover Docs", unpack(opts) })
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename Symbol", unpack(opts) })
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action", unpack(opts) })

-- 🔍 Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files", unpack(opts) })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep", unpack(opts) })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "List Buffers", unpack(opts) })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags", unpack(opts) })

-- 📁 File Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree", unpack(opts) })

-- 🖥️ Toggle Terminal
keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle Terminal", unpack(opts) })

-- 🧠 Register which-key mappings (optional)
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
