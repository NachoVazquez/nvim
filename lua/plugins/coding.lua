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
        astro = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
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
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
      "nvim-neotest/neotest-vim-test",
    },
    keys = {
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "[T]est [A]ttach",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tF",
        function()
          require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
        end,
        desc = "Debug File",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last",
      },
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>tN",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Output",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Summary",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "unittest",
          }),
          require("neotest-jest"),
          require("neotest-vitest"),
          require("neotest-playwright").adapter({
            options = {
              persist_project_selection = true,
              enable_dynamic_test_discovery = true,
            },
          }),
          require("neotest-go"),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
          }),
        },
      })
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
