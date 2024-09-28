return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "selene",
        "luacheck",
        "eslint_d",
        "shellcheck",
        "shfmt",
        "isort",
        "flake8",
        "write-good",
        "alex",
      },
    },
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      keys[#keys + 1] = { "<leader>f", require("conform").format, desc = "Format", has = "format" }
    end,
  },
}
