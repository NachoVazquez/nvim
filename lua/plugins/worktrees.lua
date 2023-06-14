return {
  {
    "ThePrimeagen/git-worktree.nvim",
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

      local function is_roost(wt_path)
        return string.find(wt_path, "roost")
      end

      local function setup_roost(wt_path)
        print("Setting up roost at " .. wt_path)

        local copy_envs_pigeon_job = Job:new({
          command = "cp",
          args = { "../develop/apps/pigeon/.env", "./apps/pigeon/" },
          cwd = wt_path,
          on_success = function(j, return_val)
            print("Copied .env file to Pigeon")
          end,
        })

        local copy_envs_parrot_job = Job:new({
          command = "cp",
          args = { "../develop/apps/parrot/.env", "./apps/parrot/" },
          cwd = wt_path,
          on_success = function(j, return_val)
            print("Copied .env file to Parrot")
          end,
        })

        local copy_envs_eagle_job = Job:new({
          command = "cp",
          args = { "../develop/apps/eagle/.env", "./apps/eagle/" },
          cwd = wt_path,
          on_success = function(j, return_val)
            print("Copied .env file to Eagle")
          end,
        })

        local copy_envs_zapier_job = Job:new({
          command = "cp",
          args = { "../develop/apps/zapier/.env", "./apps/zapier/" },
          cwd = wt_path,
          on_success = function(j, return_val)
            print("Copied .env file to Zapier")
          end,
        })

        local install_dependencies_job = Job:new({
          command = "yarn",
          args = { "install" },
          cwd = wt_path,
          on_exit = function(j, return_val)
            print("Installed dependencies")
          end,
        })

        -- copy_envs_pigeon_job.and_then(copy_envs_parrot_job)
        -- copy_envs_parrot_job.and_then(copy_envs_eagle_job)
        -- copy_envs_eagle_job.and_then(install_dependencies_job)
        -- install_dependencies_job.and_then(build_common_job)
        -- build_common_job.and_then(build_ui_job)

        -- copy_envs_pigeon_job:sync()
        -- copy_envs_parrot_job:wait()
        -- copy_envs_eagle_job:wait()
        -- install_dependencies_job:wait()
        -- build_common_job:wait()
        -- build_ui_job:wait()
        --
        copy_envs_pigeon_job:start()
        copy_envs_parrot_job:start()
        copy_envs_eagle_job:start()
        install_dependencies_job:start()
      end

      WorkTree.on_tree_change(function(op, metadata)
        if op == WorkTree.Operations.Create and is_roost(metadata.path) then
          print("Create from " .. metadata.prev_path .. " to " .. metadata.path)

          setup_roost(metadata.path)
        end

        if op == WorkTree.Operations.Switch and is_roost(metadata.path) then
          print("Switch from " .. metadata.prev_path .. " to " .. metadata.path)

          setup_roost(metadata.path)
        end
      end)
    end,
  },
}
