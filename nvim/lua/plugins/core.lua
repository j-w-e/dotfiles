return {
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
  },
  { "folke/neodev.nvim", opts = {} },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-omni',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim', opts = { } },
  { 'lewis6991/gitsigns.nvim', opts = { } },
  { 'nvim-tree/nvim-web-devicons', opts = { } },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {
      -- char = '┊',
      -- show_trailing_blankline_indent = false,
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "polirritmico/telescope-lazy-plugins.nvim",
    },
    opts = {
      extensions = {
        lazy_plugins = {
          -- this does not seem to work???
          name_only = false, -- match only the `repo_name`, false to match the full `account/repo_name`
        }
      }
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
    build = ':TSUpdate',
  },
  -- { 'stevearc/conform.nvim',
  --   opts = {
  --     formatters_by_ft = {
  --       r = { "styler", }
  --     },
  --   },
  -- },

  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = "toggle breakpoint" })
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "dap continue" })
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      -- dap.adapters.lldb = {
      --   type = 'executable',
      --   command = '/usr/bin/lldb',
      --   name = 'lldb'
      -- }
      -- dap.adapters.lldb = {
      --   type = 'executable',
      --   command = '/opt/homebrew/opt/llvm/bin/lldb', -- adjust as needed, must be absolute path
      --   name = 'lldb'
      -- }
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          -- CHANGE THIS to your path!
          command = '/Users/hughearp/.local/share/nvim/mason/bin/codelldb',
          args = {"--port", "${port}"},
        }
      }
      -- dap.configurations.c = {
      --   {
      --     name = 'Launch',
      --     type = 'lldb',
      --     request = 'launch',
      --     program = function()
      --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      --     end,
      --     cwd = '${workspaceFolder}',
      --     stopOnEntry = false,
      --     args = {},
      --   },
      -- }
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
    end
  },
  -- {
  --   "polirritmico/telescope-lazy-plugins.nvim",
  --   dependencies = { "nvim-telescope.nvim" },
  --   opts = {
  --     lazy_config = vim.fn.stdpath("config") .. "lua/plugins",
  --   }
  -- },
}
