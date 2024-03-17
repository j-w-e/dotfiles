return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "lua", "html", "dot", "javascript", "typescript", "ojs" },
      },
      codeRunner = {
        enabled = false,
        default_method = "slime",
      },
    },
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dev = false,
        dependencies = {
          { "neovim/nvim-lspconfig" },
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

  {
    "R-nvim/R.nvim",
    config = function()
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { "--quiet", "--no-save" },
        hook = {
          after_config = function()
            -- This function will be called at the FileType event
            -- of files supported by R.nvim. This is an
            -- opportunity to create mappings local to buffers.
            if vim.o.syntax ~= "rbrowser" then
              vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
              vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
            end
          end,
        },
        min_editor_width = 72,
        rconsole_width = 78,
        disable_cmds = {
          "RClearConsole",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = 1
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,
    lazy = false,
  },

  { "R-nvim/cmp-r" },

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
