return {
  {
    'folke/snacks.nvim',
    opts = {
      bigfile = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = false },
    },
    keys = {
      {
        '<leader>gl',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
    },
  },
}
