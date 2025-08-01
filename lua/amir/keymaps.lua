-- lua/amir/keymaps.lua

local M = {}

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remap ctrl-q to ctrl-v for block visual mode (Windows sucks!)
vim.keymap.set("n", "<C-q>", "<C-v>") 

-- 🔒 Core Keymaps
keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save File", unpack(opts) })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File", unpack(opts) })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to Left Window", unpack(opts) })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to Right Window", unpack(opts) })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to Lower Window", unpack(opts) })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to Upper Window", unpack(opts) })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit", unpack(opts) })



vim.keymap.set("n", "<Leader>..",":EasyNvimHelp<CR>", { desc = "Open EasyNvim Help", noremap = true, silent = true })

--OLD KEYMAP replaced with an in editor Markdown preview
--
-- vim.keymap.set("n", "<Leader>.-", function()
--   vim.cmd("EasyNvimHelp")
--   vim.cmd("MarkdownPreview")
-- end, {
--   desc = "Open EasyNvimHelp in MARKDOWN format",
--   noremap = true,
--   silent = true,
-- })


vim.keymap.set("n", "<Leader>md",":MarkdownPreview<CR>", { desc = "Open EasyNvim Help", noremap = true, silent = true })

-- Insert mode: 'jj' to exit insert mode (like <Esc>)
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj", noremap = true, silent = true })

-- Termial Mode: Exit Terminal Mode with 'jj'
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { desc = "Exit terminal mode with jj", noremap = true })

-- Dashboard HOME 
vim.keymap.set("n", "<leader>h", ":Alpha<CR>", { desc = "Open Dashboard", noremap = true, silent = true })

-- Tabs
-- Open new tab with dashboard
keymap.set("n", "<leader>tn", ":tabnew | Alpha<CR>", { desc = "New Tab with Dashboard", unpack(opts) })

vim.keymap.set("n", "<leader>tc", function()
  local tab_count = vim.fn.tabpagenr("$")
  local buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(buf)
  local ft = vim.bo[buf].filetype

  -- If it's alpha or unnamed and more than one tab, close the tab
  if (ft == "alpha" or buf_name == "") and tab_count > 1 then
    vim.cmd("tabclose")
    return
  end

  -- If it's alpha or unnamed but the LAST tab, just wipe buffer
  if (ft == "alpha" or buf_name == "") and tab_count == 1 then
    vim.api.nvim_buf_delete(buf, { force = true })
    return
  end

  -- Else: close the current buffer
  vim.cmd("bdelete")
end, { desc = "Smart Tab or Buffer Close", noremap = true, silent = true })
keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)


-- Directory Hopping!!
vim.keymap.set("n", "<leader>cd", function()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.api.nvim_echo({ { "⚠️ No file selected in active window!", "WarningMsg" } }, false, {})
    return
  end

  local dir_path = vim.fn.fnamemodify(file_path, ":h")
  vim.fn.setreg("+", dir_path)
  vim.api.nvim_echo({ { "📋 Copied directory to clipboard: " .. dir_path, "Normal" } }, false, {})
end, { desc = "Copy active file's directory to clipboard" })

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

-- Diagnostics
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })


vim.keymap.set("n", "<leader>dc", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })

  if #diagnostics == 0 then
    vim.notify("No diagnostics on this line.", vim.log.levels.WARN)
    return
  end

  -- Combine all messages into a single string
  local all_msgs = {}
  for _, diag in ipairs(diagnostics) do
    table.insert(all_msgs, diag.message)
  end
  local combined = table.concat(all_msgs, "\n")

  -- Copy to system clipboard
  vim.fn.setreg("+", combined)
  vim.notify("📋 Copied diagnostic(s) to clipboard.", vim.log.levels.INFO)
end, { desc = "Copy all diagnostics on line", noremap = true, silent = true })


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
