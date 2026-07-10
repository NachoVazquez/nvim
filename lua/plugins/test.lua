-- Run the current file with an explicit neotest adapter (IDs look like
-- "neotest-bun:/path/to/project-root").
local function run_file_with(adapter_prefix)
  local neotest = require("neotest")
  for _, id in ipairs(neotest.state.adapter_ids()) do
    if vim.startswith(id, adapter_prefix) then
      neotest.run.run({ vim.fn.expand("%"), adapter = id })
      return
    end
  end
  vim.notify("No active " .. adapter_prefix .. " adapter in this project", vim.log.levels.WARN)
end

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
    keys = {
      {
        "<leader>tb",
        function()
          run_file_with("neotest-bun")
        end,
        desc = "Run File with Bun",
      },
      {
        "<leader>tv",
        function()
          run_file_with("neotest-vitest")
        end,
        desc = "Run File with Vitest",
      },
    },
  },
}
