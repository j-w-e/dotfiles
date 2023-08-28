return {
  { 'echasnovski/mini.nvim',       version = false },
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "telekasten",
    },
    config = function()
      require("autolist").setup()

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
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
