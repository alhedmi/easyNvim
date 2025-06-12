local keymap = vim.keymap
local wk = require("which-key")
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ──────────────────────────────────────────────
-- 🚀 Non-leader keymaps
-- ──────────────────────────────────────────────
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File", noremap = true, silent = true })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File (Insert Mode)", noremap = true, silent = true })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Lower Window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Upper Window" })
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find References" })
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to Implementation" })
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })

-- ──────────────────────────────────────────────
-- 🎛️ Leader keymaps (grouped via which-key)
-- ──────────────────────────────────────────────
wk.register({
  ["<leader>"] = {
    -- File Tree
    e = { ":NvimTreeToggle<CR>", "Toggle File Tree" },

    -- Quit
    q = { ":q<CR>", "Quit" },

    -- File Search (Telescope)
    f = {
      name = "Find", -- group name
      f = { "<cmd>Telescope find_files<cr>", "Find Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    },

    -- Terminal
    t = {
      name = "Terminal",
      t = { ":ToggleTerm<CR>", "Toggle Terminal" },
    },

    -- LSP
    l = {
      name = "LSP",
      rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
      ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    },
  }
})
