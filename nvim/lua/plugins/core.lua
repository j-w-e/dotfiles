return {
  -- standard utilities
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = "top" },
        sorting_strategy = 'ascending',
        -- mappings = {
          -- i = {
            -- ["<esc>"] = require('telescope.actions').close,
          -- }
        -- }
      },
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'hrsh7th/cmp-buffer'},     -- Optional
      {'hrsh7th/cmp-path'},     -- Optional
      {'hrsh7th/cmp-nvim-lua'},     -- Optional
      {'L3MON4D3/LuaSnip'},     -- Required
      {'saadparwaiz1/cmp_luasnip'}    -- Optional
    }
  },
}
