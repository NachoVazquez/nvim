return {
  -- tools
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "css-lsp",
        "eslint-lsp",
        "html-lsp",
        "shellcheck",
        "shfmt",
        "stylua",
        "vim-language-server",
      },
    },
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "<leader>f", "<cmd>lua require('conform').format()<CR>", has = "format", desc = "Format" },
          },
        },
      },
    },
  },
}
