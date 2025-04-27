--============================================================--
--                       Neovim Plugins                        --
--                    (using lazy.nvim only)                   --
--============================================================--

require("lazy").setup({
    -- coc
{
  "neoclide/coc.nvim",
  branch = "release",
  build = "npm install",
  lazy = false, -- 바로 로딩
},
-- treesitter
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("plugin_config.treesitter")
  end,
},
    -- airline
    {
  "vim-airline/vim-airline",
  lazy = false,
},
{
  "vim-airline/vim-airline-themes",
  lazy = false,
},
    -- snippets
    { "SirVer/ultisnips", lazy = false },
{ "honza/vim-snippets", lazy = false },


-- nui (UI 컴포넌트)
{ "MunifTanjim/nui.nvim", lazy = true },

-- dressing (기본 UI 개선)
{ "stevearc/dressing.nvim", event = "VeryLazy" },

  -- NERDTree
  {
  "preservim/nerdtree",
  cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
  config = function()
    require("plugin_config.nerdtree")
  end
  },
  -- Avante AI Assistant
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    config = function()
        require("plugin_config.avante")()
    end,
    dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "stevearc/dressing.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  },
  -- Clipboard image paste
  {
    "HakonHarnes/img-clip.nvim",
    config = function()
      require("plugin_config.imgclip")
    end
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugin_config.telescope")
    end
  },

  -- Web devicons (used by telescope, file trees, etc.)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("plugin_config.webdevicons")
    end
  },

  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("plugin_config.copilot")
    end
  },

  -- nvim-cmp for autocompletion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugin_config.cmp")
    end
  },
    {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
  ft = { "markdown" },
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
    vim.g.mkdp_browser = ""
  end,
},
 { "tpope/vim-fugitive", lazy = false },


})

