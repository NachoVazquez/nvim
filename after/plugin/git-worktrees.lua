require("git-worktree").setup({
})


-- Loads the git_worktree extension if installed
local git_worktree = require('telescope').extensions.git_worktree
-- Remaps to use the git_worktree extension
vim.keymap.set('n', '<leader>gw', git_worktree.git_worktrees, { desc = '[G]it [W]orktrees' })
vim.keymap.set('n', '<leader>gc', git_worktree.create_git_worktree, { desc = '[G]it Worktree [C]reate' })
