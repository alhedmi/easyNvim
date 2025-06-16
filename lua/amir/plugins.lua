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
  { "sainnhe/gruvbox-material", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  
  {"xiyaowong/nvim-transparent",
  config = function()
    require("transparent").setup({
      enable = true,
      extra_groups = {
        "NormalFloat", "NvimTreeNormal", "TelescopeNormal"
      },
      exclude = {}, -- Or add "StatusLine", etc.
    })
  end
},
  -- Animations
 {"echasnovski/mini.animate",
  version = false,
  config = function()
    require("mini.animate").setup({
      scroll = { enable = true },
      resize = { enable = true },
      cursor = { enable = false },
      open = { enable = true },
      close = { enable = true },
    })
  end,
},

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
    


  -- Tab System 
  
   {
       "akinsho/bufferline.nvim",
       dependencies = "nvim-tree/nvim-web-devicons",
       config = function()
        require("bufferline").setup({
          options = {
            show_buffer_close_icons = true,
            show_close_icon = false,
            indicator = {
              style = "icon",
              icon = "▎"
            },
            diagnostics = "nvim_lsp",
            separator_style = "slant",
          }
        })
       end,
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

  -- 🚀 Extras

{
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_auto_start = 1  -- Optional: auto-start preview
  end,
},

  { "akinsho/toggleterm.nvim", version = "*", enabled = config.enable_terminal },
  { "goolord/alpha-nvim", enabled = config.enable_dashboard },
  { "kylechui/nvim-surround", enabled = config.enable_surround },
  { "windwp/nvim-autopairs", enabled = config.enable_autopairs },

  -- 💬 Comments
  { "numToStr/Comment.nvim", opts = {}, lazy = false },

  -- 🔀 Git integration
  { "lewis6991/gitsigns.nvim" },
}, {})
