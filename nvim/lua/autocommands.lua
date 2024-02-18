-- copy last yank to clipboard on focuslost, and back to last yank/delete on focusgained
local lastYank = vim.api.nvim_create_augroup("FocusLost", { clear = true })
vim.api.nvim_create_autocmd(
  { "FocusLost" },
  { pattern = "*", command = "let @*=@0", group = lastYank }
)
local lastCopy = vim.api.nvim_create_augroup("FocusGained", { clear = true })
vim.api.nvim_create_autocmd(
  { "FocusGained" },
  { pattern = "*", command = [[call setreg("@", getreg("+"))]], group = lastCopy }
)


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
vim.api.nvim_create_autocmd(
  "User",
  {
    pattern = "UnceptionEditRequestReceived",
    callback = function()
      -- Toggle the terminal off.
      require('FTerm').close()
    end
  }
)
