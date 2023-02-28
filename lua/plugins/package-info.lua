return {
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    keys = {
      {
        "<leader>nt",
        function()
          require("package-info").toggle()
        end,
        desc = "Toggle package info",
        silent = true,
        noremap = true,
      },
      {
        "<leader>nu",
        function()
          require("package-info").update()
        end,
        desc = "Update package info",
        silent = true,
        noremap = true,
      },
      {
        "<leader>nc",
        function()
          require("package-info").change_version()
        end,
        desc = "Change version package info",
        silent = true,
        noremap = true,
      },
    },
  }
}
