return {
  { 'echasnovski/mini.nvim', version = false },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        long_message_to_split = true,
        lsp_doc_border = true,
        command_palette = true,
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
    { 'lewis6991/gitsigns.nvim',
    config = true,
  },
  { 'nvim-tree/nvim-web-devicons',
    config = true,
  },
  {
    'nguyenvukhang/nvim-toggler',
    config = {
      inverses = {
        [ 'TRUE' ] = 'FALSE',
      },
    },
  },

  -- colorscheme
  {
    'folke/tokyonight.nvim',
    opts = { style = "moon" },
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
