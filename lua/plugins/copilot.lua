return {
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  }
}
