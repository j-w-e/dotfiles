return {
  { 'echasnovski/mini.nvim',       version = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      -- labels = "abcdefghijklmnopqrstuvwxyz",
      labels = "ersthnaiowfpluaycgdm",
      modes = {
        char = {
          char_actions = function(motion)
            return {
              [";"] = "prev", -- set to `right` to always go right
              [","] = "next", -- set to `left` to always go left
              -- clever-f style
              -- [motion:lower()] = "next",
              -- [motion:upper()] = "prev",
            }
          end,
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
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

  { 'romainl/vim-cool' },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 150,
      }
    }
  },

  -- colorscheme
  { 'ray-x/aurora' },
}
