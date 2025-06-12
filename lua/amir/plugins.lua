-- lua/amir/plugins.lua
local config = require("amir.config")

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin list
require("lazy").setup({
  -- 🌐 Plugin Manager (self)
  { "folke/lazy.nvim" },

  --  Themes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },

  --  Essentials
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.3" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  --  LSP, Completion, Snippets
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  --  Formatting & Linting
  { "stevearc/conform.nvim" },

  --  Diagnostics UI
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  --  Signature help
  config.enable_signature_help and { "ray-x/lsp_signature.nvim" } or nil,

  --  Fancy UI (optional)
  config.use_fancy_ui and {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  } or nil,

  config.enable_lspsaga and {
    "nvimdev/lspsaga.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  } or nil,

  -- 📐 Indentation guides
  config.enable_indent_guides and { "lukas-reineke/indent-blankline.nvim" } or nil,

  --  Extras
  config.enable_terminal and { "akinsho/toggleterm.nvim", version = "*"} or nil,
  config.enable_dashboard and { "goolord/alpha-nvim" } or nil,
  config.enable_surround and { "kylechui/nvim-surround" } or nil,
  config.enable_autopairs and { "windwp/nvim-autopairs" } or nil,

  -- Comments
  { "numToStr/Comment.nvim", opts = {}, lazy = false },

  --  Git integration
  { "lewis6991/gitsigns.nvim" },
}, {})
