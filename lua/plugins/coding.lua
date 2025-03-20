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
