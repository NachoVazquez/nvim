local Job = require 'plenary.job'
local WorkTree = require("git-worktree")
WorkTree.setup({
})

local function setup_roost(wt_path)
	print("Setting up roost at " .. wt_path)

	Job:new({
		command = 'cp',
		args = { '../develop/apps/pigeon/.env', './apps/pigeon/' },
		cwd = wt_path,
		on_exit = function(j, return_val)
			print("Copied .env file to Pigeon")
		end,
	}):start()

	Job:new({
		command = 'cp',
		args = { '../develop/apps/parrot/.env', './apps/parrot/' },
		cwd = wt_path,
		on_exit = function(j, return_val)
			print("Copied .env file to Parrot")
		end,
	}):start()

	Job:new({
		command = 'cp',
		args = { '../develop/apps/eagle/.env', './apps/eagle/' },
		cwd = wt_path,
		on_exit = function(j, return_val)
			print("Copied .env file to Eagle")
		end,
	}):start()

	Job:new({
		command = 'make',
		args = { 'install' },
		cwd = wt_path,
		on_exit = function(j, return_val)
			print("Installed dependencies")
		end,
	}):start()

	Job:new({
		command = 'yarn',
		args = { 'ui', 'build' },
		cwd = wt_path,
		on_exit = function(j, return_val)
			print("Built UI")
		end,
	}):start()

	Job:new({
		command = 'yarn',
		args = { 'common' },
		cwd = wt_path,
		on_exit = function(j, return_val)
			print("Built common")
		end,
	}):start()
end

-- Loads the git_worktree extension if installed
local git_worktree = require('telescope').extensions.git_worktree
-- Remaps to use the git_worktree extension
vim.keymap.set('n', '<leader>gw', git_worktree.git_worktrees, { desc = '[G]it [W]orktrees' })
vim.keymap.set('n', '<leader>gc', git_worktree.create_git_worktree, { desc = '[G]it WorkTree [C]reate' })

WorkTree.on_tree_change(function(op, metadata)
	if op == WorkTree.Operations.Create and is_roost(metadata.path) then
		print("Create from " .. metadata.prev_path .. " to " .. metadata.path)
	end

	if op == WorkTree.Operations.Switch and is_roost(metadata.path) then
		print("Switch from " .. metadata.prev_path .. " to " .. metadata.path)

		setup_roost(metadata.path)
	end
end)

function is_roost(wt_path)
	return string.find(wt_path, 'roost')
end
