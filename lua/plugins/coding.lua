return {

  -- Package Info
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
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
      {
        "<leader>ns",
        function()
          require("package-info").show({ force = true })
        end,
        desc = "Show Package Info",
        silent = true,
        noremap = true,
      },
    },
  },

  -- LSP-CONFIG
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
        -- yamlls = {
        --   settings = {
        --     yaml = {
        --       keyOrdering = false,
        --     },
        --   },
        -- },
      },
    },
  },

  -- Nvim Cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- original LazyVim kind icon formatter
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(
          opts.ensure_installed,
          { "typescript", "tsx", "php", "astro", "toml", "markdown", "markdown_inline" }
        )
      end
    end,
  },
  { "jose-elias-alvarez/typescript.nvim" },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    opts = {
      snippet_engine = "luasnip",
    },
    keys = {
      {
        "<leader>g*",
        function()
          require("neogen").generate()
        end,
        desc = "Generate",
      },
    },
  },
  {
    "f-person/git-blame.nvim",
  },
}
