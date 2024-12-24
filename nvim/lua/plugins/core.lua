return {
  -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'polirritmico/telescope-lazy-plugins.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'flex',
          layout_config = { prompt_position = 'top' },
          sorting_strategy = 'ascending',
          path_display = { 'filename_first' }, -- I may want to set this to "smart" which also works well
          mappings = {
            i = {
              ['<esc>'] = require('telescope.actions').close,
              ['<c-q>'] = require('telescope.actions').smart_send_to_qflist,
              ['jk'] = { '<esc>', type = 'command' },
              ['kj'] = { '<esc>', type = 'command' },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          lazy_plugins = {
            name_only = false, -- match only the `repo_name`, false to match the full `account/repo_name`
          },
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            sort_mru = true,
          },
        },
      }
      require('telescope').load_extension 'ui-select'
      require('telescope').load_extension 'live_grep_args'
      -- require("telescope").load_extension("dap")
    end,
  },

  { 'nvim-telescope/telescope-ui-select.nvim' },
  -- { 'nvim-telescope/telescope-dap.nvim' },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-emoji' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'f3fora/cmp-spell' },
      { 'ray-x/cmp-treesitter' },
      { 'jmbuhr/cmp-pandoc-references' },
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
      { 'onsails/lspkind-nvim' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lua' },
      -- { 'hrsh7th/cmp-omni' },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        mapping = cmp.mapping.preset.insert {
          -- up, down, c-y, c-e, c-n, c-p already set by the preset
          ['<tab>'] = {
            i = function(fallback)
              if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              elseif has_words_before() then
                cmp.complete_common_string()
              else
                fallback()
              end
            end,
            s = function(fallback)
              if luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end,
          },
          ['<s-tab>'] = {
            i = function(fallback)
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              elseif has_words_before() then
                cmp.complete_common_string()
              else
                fallback()
              end
            end,
            s = function(fallback)
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end,
          },
          ['<CR>'] = {
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm { select = false }
              else
                fallback()
              end
            end,
          },
          -- ['<c-space>'] = {
          --   i = cmp.mapping.complete(),
          -- },
        },
        --   {
        --   ['<down>'] = cmp.mapping.select_next_item(),
        --   ['<up>'] = cmp.mapping.select_prev_item(),
        --   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        --   ['<C-u>'] = cmp.mapping.scroll_docs(4),
        --   ['<c-space>'] = cmp.mapping.complete(),
        --
        --   ['<CR>'] = cmp.mapping {
        --     i = function(fallback)
        --       if cmp.visible() and cmp.get_active_entry() then
        --         cmp.confirm { select = false }
        --       else
        --         fallback()
        --       end
        --     end,
        --     s = cmp.mapping.confirm { select = false },
        --     c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
        --   },
        --   ['<C-n>'] = cmp.mapping(function(fallback)
        --     if luasnip.expand_or_jumpable() then
        --       luasnip.expand_or_jump()
        --     else
        --       fallback()
        --     end
        --   end, { 'i', 's' }),
        --   ['<C-p>'] = cmp.mapping(function(fallback)
        --     if luasnip.jumpable(-1) then
        --       luasnip.jump(-1)
        --     else
        --       fallback()
        --     end
        --   end, { 'i', 's' }),
        --   ['<C-e>'] = cmp.mapping.abort(),
        --   ['<c-y>'] = cmp.mapping.confirm {
        --     select = true,
        --   },
        --
        --   ['<Tab>'] = cmp.mapping(function(fallback)
        --     if has_words_before() then
        --       cmp.complete_common_string()
        --     elseif luasnip.expand_or_locally_jumpable() then
        --       luasnip.expand_or_jump()
        --     else
        --       fallback()
        --     end
        --   end, { 'i', 's' }),
        --   -- ['<Tab>'] = cmp.mapping(function(fallback)
        --   --   if cmp.visible() then
        --   --     cmp.select_next_item()
        --   --   elseif has_words_before() then
        --   --     cmp.complete()
        --   --   else
        --   --     fallback()
        --   --   end
        --   -- end, { 'i', 's' }),
        -- },
        autocomplete = false,

        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol',
            menu = {
              otter = '[🦦]',
              nvim_lsp = '[lsp]',
              luasnip = '[snip]',
              buffer = '[buf]',
              path = '[path]',
              spell = '[spell]',
              pandoc_references = '[ref]',
              tags = '[tag]',
              treesitter = '[ts]',
              emoji = '[emoji]',
              cmp_r = '[r]',
            },
          },
        },
        sources = {
          { name = 'otter' }, -- for code chunks in quarto
          { name = 'luasnip', keyword_length = 3, max_item_count = 3 },
          { name = 'path' },
          { name = 'cmp_r' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'treesitter', keyword_length = 5, max_item_count = 3 },
          { name = 'buffer', keyword_length = 4, max_item_count = 3 },
          { name = 'pandoc_references' },
          { name = 'spell' },
          { name = 'emoji' },
        },
        -- view = {
        --   entries = 'native',
        -- },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline {
          ['<Down>'] = { c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert } },
          ['<Up>'] = { c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert } },
          ['<tab>'] = { c = cmp.mapping.complete_common_string() },
        },
        sources = {
          { name = 'buffer' },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline {
          ['<Down>'] = { c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert } },
          ['<Up>'] = { c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert } },
          ['<tab>'] = { c = cmp.mapping.complete_common_string() },
        },
        sources = cmp.config.sources {
          { name = 'path' },
          { name = 'cmdline' },
        },
      })

      -- for friendly snippets
      require('luasnip.loaders.from_vscode').lazy_load {}
      -- for custom snippets
      require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snips' } }
      -- link quarto and rmarkdown to markdown snippets
      luasnip.filetype_extend('quarto', { 'markdown' })
      luasnip.filetype_extend('rmarkdown', { 'markdown' })
      luasnip.filetype_extend('telekasten', { 'markdown' })
      require('cmp_r').setup {}
    end,
  },

  {
    'folke/which-key.nvim',
    opts = {
      preset = 'modern',
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            return ']h'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[h', function()
          if vim.wo.diff then
            return '[h'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'reset hunk' })
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = true }
        end, { desc = 'blame line' })
        -- map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis, { desc = 'diff this' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'diff this ~' })
        -- map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  -- { 'nvim-tree/nvim-web-devicons', opts = {} },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      -- char = '┊',
      -- show_trailing_blankline_indent = false,
    },
  },

  { 'numToStr/FTerm.nvim', opts = {} },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'lua', 'markdown', 'markdown_inline', 'python', 'r', 'vimdoc', 'vim', 'yaml' },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'markdown' },
        },
        indent = { enable = true },
        -- incremental_selection = {
        --   enable = true,
        --   keymaps = {
        --     init_selection = '<c-space>',
        --     node_incremental = '<c-space>',
        --     scope_incremental = '<c-s>',
        --     node_decremental = '<M-space>',
        --   },
        -- },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = false,
            -- swap_next = {
            --   ['<leader>a'] = '@parameter.inner',
            -- },
            -- swap_previous = {
            --   ['<leader>A'] = '@parameter.inner',
            -- },
          },
        },
      }
    end,
  },
}
