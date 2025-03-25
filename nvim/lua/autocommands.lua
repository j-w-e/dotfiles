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
