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

  -- 🎨 Themes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },

  -- 🔧 Essentials
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.3" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- ⚙️ LSP, Completion, Snippets
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

  -- 🧼 Formatting & Linting
  { "stevearc/conform.nvim" },

  -- 🚨 Diagnostics UI
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- 🔍 Signature Help (optional)
  { "ray-x/lsp_signature.nvim", enabled = config.enable_signature_help },

  -- 💅 Fancy UI (optional)
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    enabled = config.use_fancy_ui
  },

  -- 📚 LSP Saga (optional)
  {
    "nvimdev/lspsaga.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = config.enable_lspsaga
  },

  -- 📐 Indentation Guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    enabled = config.enable_indent_guides
  },

  -- 📁 File Tree (optional)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
    enabled = config.enable_file_tree
  },

  -- ⌨️ Which-Key (optional)
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
    enabled = config.enable_which_key
  },
    -- 🖌️ Load Catppuccin (only if selected)
    require("catppuccin").setup({
      flavour = "mocha", -- "latte", "frappe", "macchiato", "mocha"
      integrations = {
        lualine = true,
        treesitter = true,
        telescope = true,
        which_key = true,
        notify = true,
        noice = true,
        cmp = true,
        mason = true,
        gitsigns = true,
        nvimtree = true,
      },
    })
  

  -- 🚀 Extras
  { "akinsho/toggleterm.nvim", version = "*", enabled = config.enable_terminal },
  { "goolord/alpha-nvim", enabled = config.enable_dashboard },
  { "kylechui/nvim-surround", enabled = config.enable_surround },
  { "windwp/nvim-autopairs", enabled = config.enable_autopairs },

  -- 💬 Comments
  { "numToStr/Comment.nvim", opts = {}, lazy = false },

  -- 🔀 Git integration
  { "lewis6991/gitsigns.nvim" },
}, {})
