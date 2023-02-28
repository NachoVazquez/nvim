return {
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>tt",
        function()
          require("trouble").toggle()
        end,
        desc = "[T]oggle [T]rouble",
      },
      {
        "<leader>tw",
        function()
          require("trouble").workspace_diagnostics()
        end,
        desc = "[T]rouble [W]orkspace Diagnostics",
      },
      {
        "<leader>td",
        function()
          require("trouble").document_diagnostics()
        end,
        desc = "[T]rouble [D]ocument Diagnostics",
        {
          "<leader>tf",
          function()
            require("trouble").quickfix()
          end,
          desc = "[T]rouble Quick [F]ix",
        },
      },
    },
    config = function()
      require("trouble").setup()
    end,
  }
}
