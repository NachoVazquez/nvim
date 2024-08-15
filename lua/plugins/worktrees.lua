return {
  {
    "naxodev/git-worktree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>gw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "[G]it [W]orktrees",
      },
      {
        "<leader>gc",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "[G]it WorkTree [C]reate",
      },
    },
    config = function()
      local Job = require("plenary.job")
      local WorkTree = require("git-worktree")
      WorkTree.setup({})

      local function is_js_repo(path)
        return vim.fn.filereadable(path .. "/package.json") == 1
      end

      local function get_package_manager(wt_path)
        local package_manager = "pnpm"
        if vim.fn.filereadable(wt_path .. "/package-lock.json") == 1 then
          package_manager = "npm"
        end
        if vim.fn.filereadable(wt_path .. "/yarn.lock") == 1 then
          package_manager = "yarn"
        end
        if vim.fn.filereadable(wt_path .. "/pnpm-lock.yaml") == 1 then
          package_manager = "pnpm"
        end
        return package_manager
      end

      local function install_dependencies(wt_path)
        print("Installing dependencies")

        local install_dependencies_job = Job:new({
          command = get_package_manager(wt_path),
          args = { "install" },
          cwd = wt_path,
          on_exit = function(j, return_val)
            print("Installed dependencies")
          end,
        })

        install_dependencies_job:start()
      end

      local function create_env_file(wt_path)
        local env_example_path = wt_path .. "/.env.example"
        local env_path = wt_path .. "/.env"
        if vim.fn.filereadable(env_example_path) == 1 then
          local env_example_content = vim.fn.readfile(env_example_path)
          vim.fn.writefile(env_example_content, env_path)
        end
      end

      WorkTree.on_tree_change(function(op, metadata)
        if op == WorkTree.Operations.Create and is_js_repo(metadata.path) then
          print("Create from " .. metadata.prev_path .. " to " .. metadata.path)

          install_dependencies(metadata.path)
          create_env_file(metadata.path)
        end

        if op == WorkTree.Operations.Switch and is_js_repo(metadata.path) then
          print("Switch from " .. metadata.prev_path .. " to " .. metadata.path)

          install_dependencies(metadata.path)
          create_env_file(metadata.path)
        end
      end)
    end,
  },
}
