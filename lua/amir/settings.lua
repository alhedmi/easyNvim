-- lua/amir/settings.lua
local opt = vim.opt
local g = vim.g


-- Conceallevel
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 1
    vim.opt_local.concealcursor = "nc"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"
  end,
})


-- UI
opt.number = true                -- Show line numbers
opt.relativenumber = true       -- Relative line numbers
opt.cursorline = true           -- Highlight current line
opt.termguicolors = true        -- Enable full 24-bit color

-- Tabs & Indentation
opt.tabstop = 4                 -- Number of spaces tabs count for
opt.shiftwidth = 4             -- Spaces for autoindent
opt.expandtab = true           -- Use spaces instead of tabs
opt.smartindent = true         -- Smart auto-indenting on new lines

-- Search
opt.ignorecase = true          -- Ignore case when searching
opt.smartcase = true           -- ... unless capital letters used
opt.incsearch = true           -- Show matches while typing
opt.hlsearch = false           -- Don't highlight matches

-- Scrolling
opt.scrolloff = 8              -- Minimum lines to keep above/below cursor
opt.sidescrolloff = 8

-- Clipboard
-- Uses system clipboard for all yanks, deletes, and pastes.
-- On Linux, make sure 'xclip' or 'xsel' (or 'wl-clipboard' for Wayland) is installed.
opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Windows
opt.splitbelow = true          -- Horizontal splits open below
opt.splitright = true          -- Vertical splits open to the right

-- Misc
opt.updatetime = 250           -- Faster completion (default is 4000)
opt.timeoutlen = 500           -- Time to wait for mapped sequence
opt.signcolumn = "yes"         -- Always show the sign column
opt.mouse = "a"                -- Enable mouse mode
opt.wrap = false               -- Disable line wrap

-- Disable built-in plugins we don’t use
local disabled_built_ins = {
  "gzip", "tar", "tarPlugin", "zip", "zipPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "logiPat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers"
}
for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
