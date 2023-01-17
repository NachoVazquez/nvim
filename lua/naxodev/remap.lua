-- General keymaps that are not pluggin dependant
-- the file "lua/lsp/utils.lua" contains lsp-specific commands.

local Utils = require('naxodev.utils')

local exprnnoremap = Utils.exprnnoremap
local nnoremap = Utils.nnoremap
local vnoremap = Utils.vnoremap
local xnoremap = Utils.xnoremap
local inoremap = Utils.inoremap
local map = Utils.map


-- Keymaps for better default experience
nnoremap("<leader>pv", vim.cmd.Ex)

-- kj to normal mode
inoremap("kj", "<Esc>")

-- Remap for dealing with word wrap
exprnnoremap('k', "v:count == 0 ? 'gk' : 'k'")
exprnnoremap('j', "v:count == 0 ? 'gj' : 'j'")

-- Moves selected lines up and down
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- greatest remap ever
xnoremap("<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
nnoremap("<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
inoremap("<C-c>", "<Esc>")

nnoremap("Q", "<nop>")
nnoremap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

nnoremap("<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
nnoremap("<leader>x", "<cmd>!chmod +x %<CR>")

-- Diagnostic keymaps
nnoremap('[d', vim.diagnostic.goto_prev)
nnoremap(']d', vim.diagnostic.goto_next)
-- nnoremap('<leader>e', vim.diagnostic.open_float)
-- nnoremap('<leader>q', vim.diagnostic.setloclist)

-- window management
nnoremap("<leader>sv", "<C-w>v") -- split window vertically
nnoremap("<leader>sh", "<C-w>s") -- split window horizontally
nnoremap("<leader>se", "<C-w>=") -- make split windows equal width & height
nnoremap("<leader>sx", ":close<CR>") -- close current split window

-- vim-maximizer
nnoremap("<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- restart lsp server (not on youtube nvim video)
nnoremap("<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary:
