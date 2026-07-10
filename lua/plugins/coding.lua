return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
    },
  },
  {
    "f-person/git-blame.nvim",
  },
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if require("sidekick").nes_jump_or_apply() then
            return -- jumped or applied
          end

          -- if you are using Neovim's native inline completions
          if vim.lsp.inline_completion.get() then
            return
          end

          -- any other things (like snippets) you want to do on <tab> go here.

          -- fall back to normal tab
          return "<tab>"
        end,
        mode = { "n" },
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = {
      autostart = true,
      hide_up_to_date = true,
    },
    keys = {
      {
        "<leader>ps",
        function()
          require("package-info").show()
        end,
        desc = "Show package versions",
      },
      {
        "<leader>pc",
        function()
          require("package-info").hide()
        end,
        desc = "Hide package versions",
      },
      {
        "<leader>pt",
        function()
          require("package-info").toggle()
        end,
        desc = "Toggle package versions",
      },
      {
        "<leader>pu",
        function()
          require("package-info").update()
        end,
        desc = "Update package",
      },
      {
        "<leader>pd",
        function()
          require("package-info").delete()
        end,
        desc = "Delete package",
      },
      {
        "<leader>pi",
        function()
          require("package-info").install()
        end,
        desc = "Install package",
      },
      {
        "<leader>pp",
        function()
          require("package-info").change_version()
        end,
        desc = "Change package version",
      },
    },
  },
}
