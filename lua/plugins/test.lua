return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "arthur944/neotest-bun",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
        ["neotest-bun"] = {},
      },
    },
    keys = function(_, keys)
      -- Add our custom keys
      local custom_keys = {
        -- Force bun adapter by temporarily using only bun
        {
          "<leader>tb",
          function()
            local neotest = require("neotest")
            -- Reconfigure with only bun adapter
            neotest.setup({
              adapters = {
                require("neotest-bun")({
                  cwd = function(path)
                    return require("neotest.lib").files.match_root_pattern("package.json")(path)
                  end,
                }),
              },
            })
            -- Run test
            neotest.run.run(vim.fn.expand("%"))
            -- Restore both adapters
            vim.defer_fn(function()
              neotest.setup({
                adapters = {
                  ["neotest-vitest"] = {},
                  ["neotest-bun"] = {},
                },
              })
            end, 100)
          end,
          desc = "Run File with Bun",
        },
        -- Force vitest adapter
        {
          "<leader>tv",
          function()
            local neotest = require("neotest")
            -- Reconfigure with only vitest adapter
            neotest.setup({
              adapters = {
                ["neotest-vitest"] = {},
              },
            })
            -- Run test
            neotest.run.run(vim.fn.expand("%"))
            -- Restore both adapters
            vim.defer_fn(function()
              neotest.setup({
                adapters = {
                  ["neotest-vitest"] = {},
                  ["neotest-bun"] = {},
                },
              })
            end, 100)
          end,
          desc = "Run File with Vitest",
        },
      }
      
      -- Merge with existing keys (if any)
      return vim.list_extend(keys or {}, custom_keys)
    end,
  },
}
