return {
  { 'echasnovski/mini.nvim',       version = false },
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "telekasten",
    },
  },
  {
    'gbprod/yanky.nvim',
    opts = {
      highlight = {
        timer = 250,
      },
      system_clipboard = {
        sync_with_ring = true,
      },
    }
  },
  {
    'nguyenvukhang/nvim-toggler',
    opts = { inverses = { ['TRUE'] = 'FALSE', }, },
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
  {
    'samjwill/nvim-unception',
    config = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end
  },
  { 'numToStr/FTerm.nvim',         opts = {} },
  { 'tzachar/highlight-undo.nvim', opts = {} },
  -- hardtime should teach me how to use vim, but interferes with <cr> mappings...
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     disabled_keys = {
  --       ["<Right>"] = {},
  --       ["<Left>"] = {},
  --       ["<Up>"] = {},
  --       ["<Down>"] = {},
  --     },
  --     restricted_keys = {
  --       ["<cr>"] = {},
  --     }
  --   }
  -- },
  -- colorscheme
  {
    'shaunsingh/moonlight.nvim',
    -- config = function()
    --   require('moonlight').set()
    -- end,
  },
}
