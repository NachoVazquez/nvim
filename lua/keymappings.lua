local function register_mappings(mappings, default_options)
  for mode, mode_mappings in pairs(mappings) do
    for _, mapping in pairs(mode_mappings) do
      local options = #mapping == 3 and table.remove(mapping) or default_options
      local prefix, cmd = unpack(mapping)
      pcall(vim.keymap.set, mode, prefix, cmd, options)
    end
  end
end


local border_options = { float = { border = "rounded" } }

-- NOTE<cmd> <leader> prefixed mappings are in whichkey-settings.lua

local mappings = {
  i = {
    -- Insert mode
    { "kk",    "<ESC>" },
    { "jj",    "<ESC>" },
    { "jk",    "<ESC>" },
    { "kj",    "<ESC>" },
    -- Terminal window navigation
    { "<C-h>", "<C-\\><C-N><C-w>h" },
    { "<C-j>", "<C-\\><C-N><C-w>j" },
    { "<C-k>", "<C-\\><C-N><C-w>k" },
    { "<C-l>", "<C-\\><C-N><C-w>l" },
    -- moving text
    { "<C-j>", "<esc><cmd>m .+1<CR>==" },
    { "<C-k>", "<esc><cmd>m .-2<CR>==" },
    -- Ctrl single quote for backtick
    { "<C-'>", "``<esc>i" },
  },
  n = {
    -- Normal mode
    -- Better window movement
    { "<C-h>",      "<C-w>h",                                              { silent = true } },
    { "<C-j>",      "<C-w>j",                                              { silent = true } },
    { "<C-k>",      "<C-w>k",                                              { silent = true } },
    { "<C-l>",      "<C-w>l",                                              { silent = true } },
    { "<leader>sv", "<C-w>v" },
    { "<leader>sh", "<C-w>s" },
    { "<leader>se", "<C-w>=" },
    { "<leader>sx", ":close<CR>" },
    -- Vim Maximizer
    { "<leader>sm", ":MaximizerToggle<CR>" },
    -- Resize with arrows
    { "<C-Up>",     "<cmd>resize -2<CR>",                                  { silent = true } },
    { "<C-Down>",   "<cmd>resize +2<CR>",                                  { silent = true } },
    { "<C-Left>",   "<cmd>vertical resize -2<CR>",                         { silent = true } },
    { "<C-Right>",  "<cmd>vertical resize +2<CR>",                         { silent = true } },
    -- Remap for dealing with word wrap
    { "j",          "v:count == 0 ? 'gj' : 'j'",                           { silent = true, expr = true, noremap = true } },
    { "k",          "v:count == 0 ? 'gk' : 'k'",                           { silent = true, expr = true, noremap = true } },
    -- Scroll
    { "<C-d>",      "<C-d>zz",                                             { silent = true, noremap = true } },
    { "<C-u>",      "<C-u>zz",                                             { silent = true, noremap = true } },
    -- Search goto_next
    { "n",          "nzzzv",                                               { silent = true, noremap = true } },
    { "N",          "Nzzzv",                                               { silent = true, noremap = true } },
    -- Go to Explore
    { "<leader>pv", vim.cmd.Ex },
    -- escape clears highlighting
    { "<esc>",      "<cmd>noh<cr><esc>" },
    -- Yank to clipboard
    { "<leader>y",  [["+y]] },
    { "<leader>Y",  [["+Y]] },
    -- Delete but keep yanked in register
    { "<leader>d",  [["_d]] },
    -- Nop
    { "Q",          "<nop>" },
    -- Search and Replace word under cursor
    { "<leader>wr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] },
    -- lsp mappings
    { "K",          vim.lsp.buf.hover },
    { "<C-k>",      vim.lsp.buf.signature_help },
    { "<leader>f",  '<cmd>Format<CR>' },
    {
      "[d",
      function()
        vim.diagnostic.goto_prev(border_options)
      end,
    },
    {
      "]d",
      function()
        vim.diagnostic.goto_next(border_options)
      end,
    },
    { "gD",         vim.lsp.buf.declaration },
    { "gd",         vim.lsp.buf.definition },
    { "gr",         vim.lsp.buf.references },
    { "gi",         vim.lsp.buf.implementation },
    { "<leader>rn", vim.lsp.buf.rename },
    { "<leader>ca", "<cmd>CodeActionMenu<CR>" },
    -- bufferline
    { "H",          "<cmd>BufferLineCyclePrev<CR>" },
    { "L",          "<cmd>BufferLineCycleNext<CR>" },
    { "<C-d>",      "<C-d>zz" },
    { "<C-u>",      "<C-u>zz" },
    -- Remap for dealing with line wrap
    { "k",          "v:count == 0 ? 'gk' : 'k'",                                                  { expr = true, silent = true } },
    { "j",          "v:count == 0 ? 'gj' : 'j'",                                                  { expr = true, silent = true } },
    -- open link under cursor
    { "gx",         '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>' },
    -- Auto Sessions
    { "<leader>xs", "<cmd>SaveSession<CR>" },
    { "<leader>xl", "<cmd>LoadSession<CR>" },
    { "<leader>xr", "<cmd>RestoreSession<CR>" },
    { "<leader>xd", "<cmd>DeleteSession<CR>" },
  },
  t = {
    -- Terminal mode
    -- Terminal window navigation
    { "<C-h>", "<C-\\><C-N><C-w>h" },
    { "<C-j>", "<C-\\><C-N><C-w>j" },
    { "<C-k>", "<C-\\><C-N><C-w>k" },
    { "<C-l>", "<C-\\><C-N><C-w>l" },
    -- map escape to normal mode in terminal
    { "<Esc>", [[ <C-\><C-n> ]] },
    { "jj",    [[ <C-\><C-n> ]] },
  },
  v = {
    -- Visual/Select mode
    -- Better indenting
    { "<",         "<gv" },
    { ">",         ">gv" },
    -- moving text
    { "J",         "<cmd>m '>+1<CR>gv=gv" },
    { "K",         "<cmd>m '<-2<CR>gv=gv" },
    -- Yank to clipboard
    { "<leader>y", [["+y]] },
    -- Delete but keep yanked in register
    { "<leader>d", [["_d]] },
  },
  x = {
    -- remap p to always paste from last yank
    { "<leader>p", [["_dP]] },
  },
}

register_mappings(mappings, { silent = true, noremap = true })

-- S for search and replace in buffer
vim.cmd("nnoremap S :%s/")
