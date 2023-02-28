return {
  {
    'Equilibris/nx.nvim',
    keys = {
      {
        '<leader>nx',
        function()
          require('nx.read-configs').read_nx_root()
        end,
        desc = 'Open Nx actions finder',
      },
      {
        '<leader>ng',
        function()
          require('nx.generators').generators()
        end,
        desc = 'Open Nx actions finder',
      },
    }
  }
}
