return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rmagatti/session-lens",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "arch -arm64 make" },
      "BurntSushi/ripgrep",
    },
    lazy = false,
    opts = {
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules/", "env/" }, -- ignore git
        winblend = 0,
        -- Default configuration for telescope goes here:
        mappings = {
          i = {
            ["<C-k>"] = require("telescope.actions").move_selection_previous, -- move to prev result
            ["<C-j>"] = require("telescope.actions").move_selection_next, -- move to next result
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist, -- send selected to quickfixlist      },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope.builtin").buffers({ hidden = true })
        end,
        desc = "Open buffers",
      },
      {
        "<leader>?",
        function()
          require("telescope.builtin").oldfiles({ hidden = true })
        end,
        desc = "[?] Find recently opened files",
      },
      {
        "<leader>/",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "[/] Fuzzily search in current buffer]",
      },
      {
        "<leader>sf",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").find_files()
        end,
        desc = "[S]earch [F]iles",
      },
      {
        "<leader>sh",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").help_tags()
        end,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sw",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").grep_string()
        end,
        desc = "[S]earch current [W]ord",
      },
      {
        "<leader>sg",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").live_grep()
        end,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>sd",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      {
        "<leader>sr",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "[S]earch [R]eferences",
      },
      {
        "<leader>ss",
        function()
          require("session-lens").search_session()
        end,
        desc = "[S]earch [S]essions",
      },
      {
        "<leader>st",
        "<cmd>TodoTelescope<CR>",
        desc = "[S]earch [S]essions",
      },
      {
        "<C-P>",
        function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require("telescope.builtin").git_files()
        end,
        desc = "Git Files",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("session-lens")
      telescope.load_extension("refactoring")
      telescope.load_extension("git_worktree")
    end,
  },
}
