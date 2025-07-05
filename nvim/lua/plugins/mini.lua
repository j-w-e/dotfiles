return {
  {
    'echasnovski/mini.nvim',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = false,
    config = function()
      require('mini.align').setup()
      require('mini.bufremove').setup()
      require('mini.cursorword').setup()
      require('mini.icons').setup()
      require('mini.misc').setup()
      require('mini.splitjoin').setup()
      require('mini.tabline').setup()
      require('mini.trailspace').setup()
      require('mini.visits').setup()

      local extra = require('mini.extra').gen_ai_spec
      require('mini.ai').setup {
        custom_textobjects = {
          g = extra.buffer(),
          d = { '%f[%d]%d+' }, -- digits
          -- D = extra.diagnostic(),
          -- I = extra.indent(),
          -- r = extra.line(), -- this is the inbuilt solution, which is reliable
          -- -- this is my custom solution, based on https://www.lazyvim.org/plugins/coding#miniai
          -- -- with this, `ir` works on the line excluding the initial bullet or list number
          r = function(ai_type)
            local line_num = vim.fn.line '.'
            local line = vim.fn.getline(line_num)
            -- Ignore indentation for `i` textobject
            local line_len
            if line:match '^%s*[%-%+%*]%s' then
              line_len = line:match('^%s*[%-%+%*]?%s?'):len() + 1
            elseif line:match '^%s*%d+%.%s' then
              line_len = line:match('^%s*%d+%.%s'):len() + 1
            else
              line_len = line:match('^%s*'):len() + 1
            end
            local from_col = ai_type == 'a' and 1 or line_len
            -- -- previous version: this works, except matches lines that start with two --s for example
            -- local from_col = ai_type == "a" and 1 or (line:match("^%s*[%-%+%*]?%s?"):len() + 1)
            -- Don't select `\n` past the line to operate within a line
            local to_col = line:len()
            return { from = { line = line_num, col = from_col }, to = { line = line_num, col = to_col } }
          end,
          m = function(ai_type)
            local cur_line = vim.fn.line '.'
            local lines = vim.fn.getline(1, vim.fn.line '$')
            local start_line, end_line

            -- Search upwards for start ```
            for i = cur_line, 1, -1 do
              if lines[i]:match '^```' then
                start_line = i
                break
              end
            end

            -- Search downwards for end ```
            for i = cur_line + 1, #lines do
              if lines[i]:match '^```%s*$' then
                end_line = i
                break
              end
            end

            if ai_type == 'i' then
              end_line = end_line - 1
              start_line = start_line + 1
            end

            if start_line and end_line and end_line > start_line then
              return {
                from = { line = start_line, col = 1 },
                to = { line = end_line, col = #lines[end_line] + 1 },
              }
            end
          end,

          -- N = extra.number(),
        },
      }

      require('mini.basics').setup {
        mappings = {
          option_toggle_prefix = [[<leader>vt]],
        },
      }

      -- stylua: ignore
      require("mini.bracketed").setup({
        buffer     = { suffix = "b", options = {} },
        comment    = { suffix = "c", options = {} },
        conflict   = { suffix = "x", options = {} },
        diagnostic = { suffix = "d", options = {} },
        file       = { suffix = "" },
        indent     = { suffix = "" },
        jump       = { suffix = "j", options = {} },
        location   = { suffix = "l", options = {} },
        oldfile    = { suffix = "" },
        quickfix   = { suffix = "q", options = {} },
        treesitter = { suffix = "t", options = {} },
        undo       = { suffix = "" },
        window     = { suffix = "w", options = {} },
        yank       = { suffix = "y", options = {} },
      })

      require('mini.hipatterns').setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          question = { pattern = '%f[%w]()QUESTION()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      }

      require('mini.indentscope').setup {
        options = {
          border = 'both',
          try_as_border = true,
        },
      }

      require('mini.files').setup {
        mappings = {
          go_in = 'L',
          go_in_plus = 'l',
        },
        windows = {
          preview = true,
        },
      }

      require('mini.operators').setup {
        -- Evaluate text and replace with output
        evaluate = { prefix = '' },

        -- Exchange text regions
        exchange = {
          prefix = 'gk',

          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },

        -- Multiply (duplicate) text
        multiply = {
          prefix = 'gm',

          -- Function which can modify text before multiplying
          func = nil,
        },

        -- Replace text with register
        replace = {
          prefix = 'gr',

          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },

        -- Sort text
        sort = { prefix = '' },
      }

      require('mini.pairs').setup {
        mappings = {
          -- ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%S][^%S]", register = { cr = false } },
          ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%a]' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%a]' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%a]' },
          [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
          ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
          ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
      }

      require('mini.sessions').setup {
        autowrite = false,
        directory = '~/.local/share/nvim/session', --<"session" subdir of user data directory from |stdpath()|>,
        file = 'dirSession.vim',
        force = { read = false, write = true, delete = false },
        verbose = { read = false, write = true, delete = true },
      }

      local gen_loader = require('mini.snippets').gen_loader
      -- Compute custom lookup for variables with dynamic values
      local insert_with_lookup = function(snippet)
        local lookup = {
          TM_SELECTED_TEXT = table.concat(vim.fn.getreg('+', true, true), '\n'),
        }
        return MiniSnippets.default_insert(snippet, { lookup = lookup })
      end

      -- From :h MiniSnippets to automatically stop snippet session when reaching final tabstop
      local fin_stop = function(args)
        if args.data.tabstop_to == '0' then
          MiniSnippets.session.stop()
        end
      end
      local au_opts = { pattern = 'MiniSnippetsSessionJump', callback = fin_stop }
      vim.api.nvim_create_autocmd('User', au_opts)

      -- From :h MiniSnippets.gen_loader
      local lang_patterns = {
        -- Recognize special injected language of markdown tree-sitter parser
        markdown_inline = { 'markdown.json' },
      }

      require('mini.snippets').setup {
        snippets = {
          -- Load custom file with global snippets first (adjust for Windows)
          gen_loader.from_file '~/.config/nvim/snippets/global.json',

          -- Load snippets based on current language by reading files from
          -- "snippets/" subdirectories from 'runtimepath' directories.
          gen_loader.from_lang { lang_patterns = lang_patterns },
        },
        mappings = {
          expand = '<c-s>',
          jump_next = '<tab>',
          jump_prev = '<s-tab>',
        },
        expand = { insert = insert_with_lookup },
      }

      local ministatus = require 'mini.statusline'

      -- The following code is an attempt to get lsp and formatter to display in the status line.
      -- It comes from this comment https://www.reddit.com/r/neovim/comments/xtynan/comment/iqtcq0s/?utm_source=share&utm_medium=web2x&context=3
      Lsp =
        function()
          local buf_clients = vim.lsp.get_clients { bufnr = 0 }
          -- local supported_formatters = require("null-ls.sources").get_available(vim.bo.filetype)
          local clients = {}

          for _, client in pairs(buf_clients) do
            if client.name ~= 'null-ls' then
              table.insert(clients, client.name)
            end
          end

          -- for _, client in pairs(supported_formatters) do
          --   table.insert(clients, client.name)
          -- end

          if #clients > 0 then
            return table.concat(clients, ', ')
          else
            return 'no LS'
          end
        end,
        ---@diagnostic disable-next-line: redundant-value
        ministatus.setup {
          content = {
            active = function()
              local mode, mode_hl = ministatus.section_mode { trunc_width = 120 }
              local git = ministatus.section_git { trunc_width = 75 }
              local diagnostics = ministatus.section_diagnostics { trunc_width = 75 }
              local filename = ministatus.section_filename { trunc_width = 140 }
              local fileinfo = ministatus.section_fileinfo { trunc_width = 120 }
              local location = ministatus.section_location { trunc_width = 75 }
              local lsp = Lsp()
              local noice_mode = require('noice').api.status.mode.get_hl()

              return ministatus.combine_groups {
                { hl = mode_hl, strings = { mode } },
                { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                -- { hl = 'MiniStatuslineFileinfo', strings = { noice_cmd, noice_mode } },
                { hl = 'MiniStatuslineFileinfo', strings = { noice_mode } },
                { hl = 'MiniStatuslineFilename', strings = { lsp } },
                { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                { hl = mode_hl, strings = { location } },
              }
            end,
          },
        }

      local ministart = require 'mini.starter'
      ministart.setup {
        evaluate_single = true,
        items = {
          ministart.sections.sessions(6, false),
          ministart.sections.recent_files(10, false),
          ministart.sections.builtin_actions(),
        },
        content_hooks = {
          ministart.gen_hook.adding_bullet(),
          ministart.gen_hook.indexing(),
          ministart.gen_hook.aligning('center', 'center'),
        },
      }

      require('mini.surround').setup {
        mappings = {
          add = 'gsa', -- Add surrounding in Normal and Visual modes
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding
          update_n_lines = 'gsn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      }
    end,
  },
}
