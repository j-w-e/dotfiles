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
  { 'samjwill/nvim-unception',
    config = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end},
  { 'numToStr/FTerm.nvim', opts = { } },
  -- colorscheme
  {
    'folke/tokyonight.nvim',
    opts = { style = "night" },
    -- config = function()
    --   -- load the colorscheme here
    --   vim.cmd([[colorscheme tokyonight]])
    -- end,
  },
}
