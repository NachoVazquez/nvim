-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertically" })
vim.keymap.set("n", "<leader>s-", "<C-w>s", { desc = "[S]plit [H]orizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "[S]plit [E]qually" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "[S]plit [E]qually" })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })

vim.keymap.set("i", "kk", "<ESC>", { desc = "Exit insert mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<cr>", "ciw")
vim.keymap.set("n", "<bs>", "diw")

vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Navigate left" })
vim.keymap.set("n", "<C-w>j", "<cmd> TmuxNavigateDown<CR>", { desc = "Navigate down" })
vim.keymap.set("n", "<C-w>k", "<cmd> TmuxNavigateUp<CR>", { desc = "Navigate up" })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Navigate right" })

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
