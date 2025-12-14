-- -- copy last yank to clipboard on focuslost, and back to last yank/delete on focusgained
-- local lastYank = vim.api.nvim_create_augroup('FocusLost', { clear = true })
-- vim.api.nvim_create_autocmd({ 'FocusLost' }, { pattern = '*', command = 'let @*=@0', group = lastYank })
-- local lastCopy = vim.api.nvim_create_augroup('FocusGained', { clear = true })
-- vim.api.nvim_create_autocmd({ 'FocusGained' }, { pattern = '*', command = [[call setreg("@", getreg("+"))]], group = lastCopy })

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'help',
    'dashboard',
    'lazy',
    'mason',
    'notify',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- allow vim-unception to work with FTerm
vim.api.nvim_create_autocmd('User', {
  pattern = 'UnceptionEditRequestReceived',
  callback = function()
    -- Toggle the terminal off.
    require('FTerm').close()
  end,
})

-- Don't show line numbers in terminals
local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = { '*' },
  callback = function(_)
    vim.cmd.setlocal 'nonumber'
    set_terminal_keymaps()
  end,
})

-- Automatically trigger a reload / re-check of file status if it's changed on disk.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = { '*' },
  command = 'checktime',
})

-- Automatically jump to last cursor position on re-opening a file
-- Taken from https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match 'commit' and ft:match 'rebase') and last_known_line > 1 and last_known_line <= vim.api.nvim_buf_line_count(opts.buf) then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on valid entry'
  end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then
    return vim.notify 'Cursor is not on valid entry'
  end
  vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function()
  vim.ui.open(MiniFiles.get_fs_entry().path)
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set('n', 'g~', set_cwd, { buffer = b, desc = 'Set cwd' })
    vim.keymap.set('n', 'gX', ui_open, { buffer = b, desc = 'OS open' })
    vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'ObsidianNoteEnter',
  callback = function(ev)
    vim.wo.spell = true
    local action = '<Esc>[s1z=gi<Right>'
    vim.keymap.set('i', 'kk', action, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowUpdate',
  callback = function(ev)
    local state = MiniFiles.get_explorer_state() or {}

    local win_ids = vim.tbl_map(function(t)
      return t.win_id
    end, state.windows or {})

    local function idx(win_id)
      for i, id in ipairs(win_ids) do
        if id == win_id then
          return i
        end
      end
    end

    local this_win_idx = idx(ev.data.win_id)
    local focused_win_idx = idx(vim.api.nvim_get_current_win())

    -- this_win_idx can be nil sometimes when opening fresh minifiles
    if this_win_idx and focused_win_idx then
      -- idx_offset is 0 for the currently focused window
      local idx_offset = this_win_idx - focused_win_idx

      -- the width of windows based on their distance from the center
      -- i.e. center window is 60, then next over is 20, then the rest are 10.
      -- Can use more resolution if you want like { 60, 30, 20, 15, 10, 5 }
      local widths = { 60, 20, 10 }

      local i = math.abs(idx_offset) + 1 -- because lua is 1-based lol
      local win_config = vim.api.nvim_win_get_config(ev.data.win_id)
      win_config.width = i <= #widths and widths[i] or widths[#widths]

      local offset = 0
      for j = 1, math.abs(idx_offset) do
        local w = widths[j] or widths[#widths]
        -- and an extra +2 each step to account for the border width
        local _offset = 0.5 * (w + win_config.width) + 2
        if idx_offset > 0 then
          offset = offset + _offset
        elseif idx_offset < 0 then
          offset = offset - _offset
        end
      end

      win_config.height = idx_offset == 0 and 25 or 20
      win_config.row = math.floor(0.5 * (vim.o.lines - win_config.height))
      win_config.col = math.floor(0.5 * (vim.o.columns - win_config.width) + offset)
      vim.api.nvim_win_set_config(ev.data.win_id, win_config)
    end
  end,
})
