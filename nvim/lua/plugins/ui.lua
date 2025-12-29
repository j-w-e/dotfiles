return {
  { 'meznaric/key-analyzer.nvim', opts = {} },
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
      -- labels = "enaiorsthwfpluaycgdm",
      labels = 'enaiohtsrluypfwmdgc',
      search = {
        mode = 'search',
      },
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
    config = function()
      vim.cmd [[let g:bullets_delete_last_bullet_if_empty = 2]]
    end,
    ft = {
      'markdown',
      'telekasten',
      'text',
      'scratch',
    },
  },

  -- {
  --   "gbprod/yanky.nvim",
  --   opts = {
  --     highlight = {
  --       timer = 250,
  --     },
  --     system_clipboard = {
  --       sync_with_ring = true,
  --     },
  --   },
  -- },

  {
    'nguyenvukhang/nvim-toggler',
    opts = { inverses = { ['TRUE'] = 'FALSE' } },
  },

  -- {
  --   'folke/noice.nvim',
  --   -- event = "VeryLazy",
  --   opts = {
  --     presets = {
  --       long_message_to_split = true,
  --       lsp_doc_border = true,
  --       command_palette = true,
  --     },
  --   },
  --   dependencies = {
  --     'MunifTanjim/nui.nvim',
  --     'rcarriga/nvim-notify',
  --   },
  -- },

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
    config = function()
      local hydra = require 'hydra'
      require('hydra').setup {
        timeout = 4000,
      }

      hydra {
        name = 'Side scroll',
        hint = [[ Side scroll ]],
        mode = 'n',
        body = 'z',
        heads = {
          { 'h', '5zh' },
          { 'l', '5zl', { desc = '←/→' } },
          { 'H', 'zH' },
          { 'L', 'zL', { desc = 'half screen ←/→' } },
        },
      }

      hydra {
        name = 'Buffers',
        hint = [[Buffers]],
        mode = 'n',
        body = 't',
        config = { color = 'pink' },
        heads = {
          {
            'h',
            function()
              vim.cmd 'bprev'
            end,
            { desc = 'Prev buffer' },
          },
          {
            'l',
            function()
              vim.cmd 'bnext'
            end,
            { desc = 'Next buffer' },
          },
          {
            'x',
            function()
              MiniBufremove.delete(0)
            end,
            { desc = 'Close buffer' },
          },
          {
            'n',
            function()
              JumpToTODO(true)
            end,
            { desc = 'jump to next todo' },
          },
          {
            'p',
            function()
              JumpToTODO(false)
            end,
            { desc = 'jump to prev todo' },
          },
          { '<Esc>', nil, { exit = true } },
        },
      }

      hydra {
        name = 'Windows',
        hint = [[Windows]],
        -- config = {
        --   invoke_on_body = true,
        --   hint = {
        --     border = 'rounded',
        --     offset = -1,
        --   },
        -- },
        mode = 'n',
        body = '<C-w>',
        heads = {
          { 'h', '<cmd>vertical resize -20<cr>', { desc = 'resize -20' } },
          { 'l', '<cmd>vertical resize +20<cr>', { desc = 'resize +20' } },

          { '=', '<C-w>=', { desc = 'equalize' } },

          { 's', '<cmd>sp<cr>', { desc = 'new horz split' } },
          { 'v', '<cmd>vs<cr>', { desc = 'new vert split' } },

          { 'w', '<C-w>w', { exit = true, desc = false } },
          { '<C-w>', '<C-w>w', { exit = true, desc = false } },

          { '<Esc>', nil, { exit = true, desc = false } },
        },
      }

      -- hydra {
      --   name = 'R chunks',
      --   hint = [[ Navigate R chunks ]],
      --   mode = 'n',
      --   body = 'z',
      --   heads = {
      --     { 'h', '5zh' },
      --     { 'l', '5zl', { desc = '←/→' } },
      --     { 'H', 'zH' },
      --     { 'L', 'zL', { desc = 'half screen ←/→' } },
      --   },
      -- }
    end,
  },

  -- {
  --   'ptdewey/yankbank-nvim',
  --   name = 'yankbank',
  --   opts = {
  --     max_entries = 9,
  --     num_behavior = 'jump',
  --     registers = {
  --       yank_register = '@',
  --     },
  --   },
  -- },
  -- colorscheme
  -- { 'ray-x/aurora' },
  -- { 'e-q/okcolors.nvim' },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   opts = {
  --     variant = 'moon',
  --     groups = { todo = 'gold' },
  --     highlight_groups = { Normal = { fg = 'iris' }, MiniHipatternsTodo = { fg = 'gold' } },
  --   },
  -- },
  -- { 'fynnfluegge/monet.nvim' },
  -- { "rktjmp/lush.nvim" },
  -- { 'rebelot/kanagawa.nvim' },
  -- { 'marko-cerovac/material.nvim' },
  -- { 'Mofiqul/dracula.nvim' },
  -- { "jim-at-jibba/ariake.nvim" },
  -- { "j-w-e/ariake.nvim" },
  -- {
  --   'eldritch-theme/eldritch.nvim',
  --   opts = {
  --     on_colors = function(colors)
  --       colors.fg = colors.purple
  --     end,
  --     on_highlights = function(highlights, colors)
  --       highlights.String = { fg = colors.dark_green }
  --     end,
  --   },
  -- },
  -- { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
      on_highlights = function(highlights, colors)
        highlights.FlashLabel = { bg = colors.blue0, fg = colors.magenta }
        highlights.MiniTrailspace = { fg = colors.magenta }
        highlights.CursorLine = { bg = colors.fg_gutter }
        -- highlights.RenderMarkdownCode = { bg = colors.fg_gutter }  -- this is a lighter backgroud for code blocks. I got tired of it
        highlights.RenderMarkdownCode = { bg = '#16161e' } -- this is for a dark background to code blocks
      end,
    },
  },
}
