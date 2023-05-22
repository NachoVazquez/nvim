return {
  -- neorg
  -- {
  --   "nvim-neorg/neorg",
  --   ft = "norg",
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {},
  --       ["core.norg.concealer"] = {},
  --       ["core.norg.completion"] = {
  --         config = { engine = "nvim-cmp" },
  --       },
  --       ["core.integrations.nvim-cmp"] = {},
  --     },
  --   },
  -- },
  -- Obsidian
  {
    "epwalsh/obsidian.nvim",
    opts = {
      dir = "~/Documents/mind-map/",
      completion = {
        nvim_cmp = true,
      },
      daily_notes = {
        folder = "journal",
      },
    },
    keys = {
      {
        "gf",
        function()
          if require("obsidian").util.cursor_on_markdown_link() then
            return "<cmd>ObsidianFollowLink<CR>"
          else
            return "gf"
          end
        end,
        desc = "Follow Link",
        noremap = true,
        expr = true,
      },
      {
        "<leader>oj",
        "<cmd>ObsidianToday<CR>",
        desc = "Obsidian Journal Today",
      },
      {
        "<leader>os",
        "<cmd>ObsidianSearch<CR>",
        desc = "Obsidian Search",
      },
      {
        "<leader>ol",
        "<cmd>ObsidianLinkNew<CR>",
        desc = "Obsidian Link New",
      },
    },
  },
}
