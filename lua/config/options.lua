vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- vim-dadbod connections live outside the repo (contains credentials)
local dbs_file = vim.fn.stdpath("data") .. "/dbs.lua"
if vim.uv.fs_stat(dbs_file) then
  vim.g.dbs = dofile(dbs_file)
end
