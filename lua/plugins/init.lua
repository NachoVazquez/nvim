return {
  -- NOTE: plugins here require little to no configuratin

  -- GIT
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "tpope/vim-rhubarb",
  "lewis6991/gitsigns.nvim",
  "rbong/vim-flog",

  "nvim-lua/plenary.nvim",
  "windwp/nvim-autopairs",
  {
    "windwp/nvim-spectre", -- Spectre for find and replace
    keys = {
      {
        "<leader>S",
        function()
          require("spectre").open()
        end,
        desc = "Search and replace",
      },
    },
  },
  "mhartington/formatter.nvim",
  "goolord/alpha-nvim",
  "nvim-tree/nvim-web-devicons",
  "tpope/vim-sleuth",
  "tpope/vim-abolish",

  -- Useful status updates for LSP
  { "j-hui/fidget.nvim", opts = { window = { border = "rounded", blend = 0 } } },
  { "numToStr/Comment.nvim", opts = {} },
  "rmagatti/auto-session",
  "weilbith/nvim-code-action-menu",
  "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports)
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("todo-comments").setup()
    end,
  },
}
