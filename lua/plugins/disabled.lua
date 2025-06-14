return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },
  { "ggandor/leap.nvim", enabled = false },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  -- Disable just the <leader>gc keybinding from gitsigns
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>gc", false },
    },
  },
}
