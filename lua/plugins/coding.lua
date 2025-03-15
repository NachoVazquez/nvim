return {
  {
    "saghen/blink.cmp",

    keymap = {
      ["<C-j>"] = { "select_prev", "fallback" },
      ["<C-k>"] = { "select_next", "fallback" },
    },
  },

  {
    "f-person/git-blame.nvim",
  },

  {
    "mfussenegger/nvim-lint",
    keymap = {
      ["<leader>er"] = { "<cmd>GoIfErr<cr>", desc = "Add error handling" },
    },
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
      },
      -- Don't automatically lint on write or change
      -- LazyVim adds this configuration itself
    },
  },
  -- Database
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    opts = {
      db_competion = function() end,
    },
    config = function(_, opts)
      vim.g.db_ui_save_location = "~/work/nvim/db_ui"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function()
          vim.schedule(opts.db_completion)
        end,
      })
    end,
    keys = {
      { "<leader>Dt", "<cmd>DBUIToggle<cr>", desc = "Toggle UI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer" },
      { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Buffer" },
      { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
}
