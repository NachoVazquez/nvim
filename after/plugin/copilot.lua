vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-Enter>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
