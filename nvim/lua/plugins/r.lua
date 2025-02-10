return {
  -- {
  --   'quarto-dev/quarto-nvim',
  --   ft = { 'quarto' },
  --   dev = false,
  --   opts = {
  --     lspFeatures = {
  --       languages = { 'r' },
  --     },
  --     codeRunner = {
  --       enabled = false,
  --       default_method = nil,
  --     },
  --   },
  --   dependencies = {
  --     {
  --       'jmbuhr/otter.nvim',
  --       dev = false,
  --       dependencies = {
  --         { 'neovim/nvim-lspconfig' },
  --       },
  --       opts = {
  --         -- lsp = {
  --         --   hover = {
  --         --     border = require('misc.style').border,
  --         --   },
  --         -- },
  --         buffers = {
  --           set_filetype = true,
  --         },
  --         handle_leading_whitespace = true,
  --       },
  --     },
  --   },
  -- },

  {
    'R-nvim/R.nvim',
    config = function()
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { '--quiet', '--no-save' },
        hook = {
          on_filetype = function()
            -- This function will be called at the FileType event
            -- of files supported by R.nvim. This is an
            -- opportunity to create mappings local to buffers.
            vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
            vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>rr', '<cmd>RMapsDesc<cr>', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>rx', '<Plug>RClose', {})
            vim.api.nvim_buf_set_keymap(0, 'i', '%%', ' %>%', {})
            -- vim.api.nvim_buf_set_keymap(0, 'i', '<c-,>', ' |>', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<localleader><Enter>', '<Plug>RSendLine', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>b', '<Plug>RPreviousRChunk', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>n', '<Plug>RNextRChunk', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>h', '<Plug>RHelp', {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>rh', "<cmd>lua require('r.run').action('head', 'n', ', n = 15')<cr>", {})
            vim.api.nvim_buf_set_keymap(0, 'n', '<LocalLeader>kx', "<cmd>lua require('r.rmd').make('pptx')<cr>", {})

            require 'hydra' {
              name = 'R',
              hint = [[ Scroll or send-to-R ]],
              mode = 'n',
              body = '<localleader>',
              heads = {
                { 'n', '<Plug>RNextRChunk', { desc = 'Next R chunk' } },
                { 'b', '<Plug>RPreviousRChunk', { desc = 'Prev R chunk' } },
                { 'cd', '<Plug>RDSendChunk', { exit = true, desc = 'Run chunk and go to next' } },
                { 'cc', '<Plug>RSendChunk', { exit = true, desc = 'Run chunk' } },
              },
              config = {
                buffer = true,
              },
            }
          end,
        },
        min_editor_width = 72,
        rconsole_width = 78,
        rm_knit_cache = true,
        rmdchunk = '',
        disable_cmds = {
          'RClearConsole',
          'RCustomStart',
          'RSPlot',
          'RSaveClose',
          'RDSendMBlock',
          'RSendMBlock',
        },
        assignment_keymap = '<c-->',
        pipe_keymap = '<space><space>',
        -- pipe_keymap = '<c-,>',
        pdfviewer = 'open',
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- this is in my .zshrc: alias r="R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == 'true' then
        opts.auto_start = 'on startup'
        -- opts.objbr_auto_start = true
      end
      require('r').setup(opts)
    end,
    lazy = false,
  },

  { 'R-nvim/cmp-r' },

  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1001, -- this plugin needs to run before anything else
  --   opts = {
  --     rocks = { 'magick' },
  --   },
  -- },
  -- The below works, but I don't have need for it currently!
  -- { -- show images in nvim!
  --   '3rd/image.nvim',
  --   enabled = true,
  --   config = function()
  --     -- Requirements
  --     -- https://github.com/3rd/image.nvim?tab=readme-ov-file#requirements
  --     -- check for dependencies with `:checkhealth kickstart`
  --     -- otherwise set `enabled = false` in the plugin spec
  --     -- Example for configuring Neovim to load user-installed installed Lua rocks:
  --     --$ luarocks --local --lua-version=5.1 install magick
  --     package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
  --     package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'
  --
  --     require('image').setup {
  --       backend = 'kitty',
  --       integrations = {
  --         markdown = {
  --           enabled = true,
  --           only_render_image_at_cursor = true,
  --           filetypes = { 'markdown', 'vimwiki', 'quarto' },
  --         },
  --       },
  --       max_width = 100,
  --       max_height = 15,
  --       -- auto show/hide images when the editor gains/looses focus
  --       editor_only_render_when_focused = false,
  --       -- toggles images when windows are overlapped
  --       window_overlap_clear_enabled = false,
  --       -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  --       tmux_show_only_in_active_window = true,
  --     }
  --   end,
  -- },
}
