return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html', 'dot', 'javascript', 'typescript', 'ojs' },
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime',
      },
    },
    dependencies = {
      {
        'jmbuhr/otter.nvim',
        dev = false,
        dependencies = {
          { 'neovim/nvim-lspconfig' },
        },
        opts = {
          -- lsp = {
          --   hover = {
          --     border = require('misc.style').border,
          --   },
          -- },
          buffers = {
            set_filetype = true,
          },
          handle_leading_whitespace = true,
        },
      },
    },
  },

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
