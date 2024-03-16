return {
  { 'numToStr/FTerm.nvim', opts = {} },
  {
    'chrishrb/gx.nvim',
    keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
    cmd = { 'Browse' },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
    submodules = false, -- not needed, submodules are required only for tests
    opts = {
      handler_options = {
        -- you can select between google, bing, duckduckgo, and ecosia
        search_engine = 'duckduckgo',
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      -- labels = "abcdefghijklmnopqrstuvwxyz",
      labels = 'ersthnaiowfpluaycgdm',
      modes = {
        char = {
          char_actions = function()
            return {
              [';'] = 'prev', -- set to `right` to always go right
              [','] = 'next', -- set to `left` to always go left
            }
          end,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    'bullets-vim/bullets.vim',
    ft = {
      'markdown',
      'telekasten',
      'text',
      'scratch',
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
    },
  },

  {
    'nguyenvukhang/nvim-toggler',
    opts = { inverses = { ['TRUE'] = 'FALSE' } },
  },

  {
    'folke/noice.nvim',
    -- event = "VeryLazy",
    opts = {
      presets = {
        long_message_to_split = true,
        lsp_doc_border = true,
        command_palette = true,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  {
    'samjwill/nvim-unception',
    config = function()
      vim.g.unception_open_buffer_in_new_tab = true
    end,
  },

  { 'tzachar/highlight-undo.nvim', opts = {} },

  { 'romainl/vim-cool' },

  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 150,
      },
    },
  },

  {
    'nvimtools/hydra.nvim',
    -- config = function ()
    -- local function keys(str)
    --   return function()
    --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
    --   end
    -- end
    --
    -- local hydra = require("hydra")
    -- hydra({
    --     name = "R REPL",
    --     hint = [[
    --       _j_/_k_: move down/up  _r_: run cell
    --       _l_: run line  _R_: run above
    --       ^^     _<esc>_/_q_: exit ]],
    --     config = {
    --         color = "teal",
    --         invoke_on_body = true,
    --         hint = {
    --             border = "rounded", -- you can change the border if you want
    --         },
    --     },
    --     mode = { "n" },
    --     body = "<localleader>j", -- this is the key that triggers the hydra
    --     heads = {
    --         -- { "j", keys("]b") },
    --         -- { "k", keys("[b") },
    --         -- { "r", ":QuartoSend<CR>" },
    --         -- { "l", ":QuartoSendLine<CR>" },
    --         -- { "R", ":RSendLine<CR>" },
    --         -- { "<esc>", nil, { exit = true } },
    --         -- { "q", nil, { exit = true } },
    --     },
    -- })
    -- end
  },

  -- colorscheme
  { 'ray-x/aurora' },
}
