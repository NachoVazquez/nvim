-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "[S]plit [E]qually" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "[S]plit [E]qually" })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })

vim.keymap.set("i", "kk", "<ESC>", { desc = "Exit insert mode" })
