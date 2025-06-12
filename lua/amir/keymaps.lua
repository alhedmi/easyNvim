local wk = require("which-key")
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Define keymaps in recommended spec format
local mappings = {
  ["<leader>"] = {
    e = { ":NvimTreeToggle<CR>", "Toggle File Tree" },
    q = { ":q<CR>", "Quit" },
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<cr>", "Find Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    },
    l = {
      name = "LSP",
      rn = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
      ca = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    },
    t = {
      name = "Terminal",
      t = { ":ToggleTerm<CR>", "Toggle Terminal" },
    },
  }
}

wk.register(mappings, { mode = "n" }) -- normal mode

-- Other keymaps not shown in which-key
vim.keymap.set("n", "<C-s>", ":w<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)

vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
