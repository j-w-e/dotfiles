return {
  { 'echasnovski/mini.nvim', version = false },
  { 'nguyenvukhang/nvim-toggler',
    opts = { inverses = { [ 'TRUE' ] = 'FALSE', }, },
  },
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
  -- colorscheme
  {
    'folke/tokyonight.nvim',
    opts = { style = "moon" },
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- { "gaoDean/autolist.nvim",
    -- ft = { "markdown", "telekasten", "text", },
    -- config = function()
    --   require("autolist").setup()
    --   vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
    --   -- functions to recalculate list on edit
    --   vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>" )
    --   vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
    --   vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
    --   vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    -- end
  -- }
}
