return {

  -- copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    event = "VeryLazy",
    config = true,
  },

  -- Package Info
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    keys = {
      {
        "<leader>nt",
        function()
          require("package-info").toggle()
        end,
        desc = "Toggle package info",
        silent = true,
        noremap = true,
      },
      {
        "<leader>nu",
        function()
          require("package-info").update()
        end,
        desc = "Update package info",
        silent = true,
        noremap = true,
      },
      {
        "<leader>nc",
        function()
          require("package-info").change_version()
        end,
        desc = "Change version package info",
        silent = true,
        noremap = true,
      },
    },
  },

  -- Nx
  {
    "Equilibris/nx.nvim",
    keys = {
      {
        "<leader>nx",
        function()
          require("nx.read-configs").read_nx_root()
        end,
        desc = "Open Nx actions finder",
      },
      {
        "<leader>ng",
        function()
          require("nx.generators").generators()
        end,
        desc = "Open Nx actions finder",
      },
    },
  },

  -- LSP-CONFIG
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {},
        astro = {},
      },
    },
  },

  -- Nvim Cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  { "jose-elias-alvarez/typescript.nvim" },
}
