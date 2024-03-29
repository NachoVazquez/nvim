return {
  {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("refactoring").setup()
    end,
    keys = {
      {
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        mode = "v",
        desc = "Extract Function",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        mode = "v",
        desc = "Extract Function To File",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        mode = "v",
        desc = "Extract Variable",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        mode = "v",
        desc = "Inline Variable",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rb",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        desc = "Extract Block",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rbf",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        desc = "Extract Block To File",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>ri",
        [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        desc = "Inline Variable",
        noremap = true,
        silent = true,
        expr = false,
      },
      {
        "<leader>rr",
        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
        mode = "v",
        noremap = true,
      },
    },
  },
}
