-- lua/amir/keymaps.lua
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Set <Space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- map "<leader>e" to "NvimTreeToggle"
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })


-- map "<Ctrl-s>" to save in normal and insert mode
keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

-- map "<leader>q" to quit
keymap.set("n", "<leader>q", ":q<CR>", opts)

-- map "<Ctrl-h/j/k/l>" to switch windows
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)

-- map "<leader>ff" to Telescope find_files
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)

-- map "<leader>fg" to Telescope live_grep
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)

-- map "<leader>fb" to Telescope buffers
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)

-- map "<leader>fh" to Telescope help_tags
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

-- map "<leader>tt" to toggle terminal
keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", opts)

-- map "gd" to go to definition
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- map "gr" to show references
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- map "gi" to go to implementation
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

-- map "K" to hover documentation
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

-- map "<leader>rn" to rename symbol
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

-- map "<leader>ca" to code actions
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
