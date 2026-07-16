return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  init = function()
    -- Let vim-herdr-navigation own <C-h/j/k/l>; keep the plugin for $TMUX fallback.
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local matches = vim.fn.glob(
      vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua"),
      false,
      true
    )
    if matches[1] then
      dofile(matches[1])
    else
      vim.notify("vim-herdr-navigation nvim.lua not found", vim.log.levels.WARN)
    end
  end,
}
