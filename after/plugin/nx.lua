require('nx').setup {
}
vim.keymap.set('n', '<leader>nx', require('nx.read-configs').read_nx_root, { desc = "Open Nx actions finder" })
vim.keymap.set('n', '<leader>ng', require('nx.generators').generators, { desc = "Open Nx actions finder" })
