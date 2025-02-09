-- -- copy last yank to clipboard on focuslost, and back to last yank/delete on focusgained
-- local lastYank = vim.api.nvim_create_augroup('FocusLost', { clear = true })
-- vim.api.nvim_create_autocmd({ 'FocusLost' }, { pattern = '*', command = 'let @*=@0', group = lastYank })
-- local lastCopy = vim.api.nvim_create_augroup('FocusGained', { clear = true })
-- vim.api.nvim_create_autocmd({ 'FocusGained' }, { pattern = '*', command = [[call setreg("@", getreg("+"))]], group = lastCopy })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "dashboard",
    "lazy",
    "mason",
    "notify",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- allow vim-unception to work with FTerm
vim.api.nvim_create_autocmd("User", {
  pattern = "UnceptionEditRequestReceived",
  callback = function()
    -- Toggle the terminal off.
    require("FTerm").close()
  end,
})

-- Don't show line numbers in terminals
local function set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function(_)
    vim.cmd.setlocal("nonumber")
    set_terminal_keymaps()
  end,
})

-- Automatically trigger a reload / re-check of file status if it's changed on disk.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = { "*" },
  command = "checktime",
})

-- Automatically jump to last cursor position on re-opening a file
-- Taken from https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd("BufRead", {
  callback = function(opts)
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})
