local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ──────────────────────────────────────────────
-- 🚀 Non-leader keymaps
-- ──────────────────────────────────────────────

-- 💾 Save
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File" })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File (Insert Mode)" })

-- 🪟 Window Navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Lower Window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Upper Window" })

-- 💡 LSP Navigation
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { desc = "Find References" })
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to Implementation" })
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })
