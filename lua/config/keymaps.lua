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

-- <C-h/j/k/l>: vim-herdr-navigation (Herdr panes + Neovim splits; tmux fallback).
-- Loaded here on VeryLazy so these win over LazyVim's default window maps.
do
  local matches = vim.fn.glob(
    vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-*/editor/nvim.lua"),
    false,
    true
  )
  if matches[1] then
    dofile(matches[1])
  end
end

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
