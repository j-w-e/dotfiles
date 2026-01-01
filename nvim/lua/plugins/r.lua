return {
  {
    'R-nvim/R.nvim',
    -- branch = "rmd_chunk_keymap",
    config = function()
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { '--quiet', '--no-save' },
        hook = {
          on_filetype = function()
            -- This function will be called at the FileType event
            -- of files supported by R.nvim. This is an
            -- opportunity to create mappings local to buffers.
            vim.api.nvim_buf_set_keymap(0, 'i', '<c-->', '<Plug>RInsertAssign', { noremap = true })
            vim.api.nvim_buf_set_keymap(0, 'i', '<space><space>', '<Plug>RInsertPipe', { noremap = true })
            vim.api.nvim_buf_set_keymap(0, 'i', '`', '<Plug>RmdInsertChunk', { noremap = true })
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
        disable_cmds = {
          'RClearConsole',
          'RCustomStart',
          'RSPlot',
          'RSaveClose',
          'RDSendMBlock',
          'RSendMBlock',
        },
        -- Keymaps
        -- assignment_keymap = '<c-->',
        -- pipe_keymap = '<space><space>',
        -- pipe_keymap = '<c-,>',
        -- rmd_chunk_keymap = '`',
        pdfviewer = 'open',
        quarto_chunk_hl = {
          highlight = true,
          virtual_title = true,
          -- bg = '',
          events = '',
        },
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
}
