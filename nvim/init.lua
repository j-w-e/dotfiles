-- TODO:
-- 1. Add Hydras for git?
-- 10. Add a command to set the wd if opening with a file?
-- 12. Possibly related, make lps format work again for R / Rmd / qmd files
-- 13. this link gives some useful info about default mappings: https://docs.google.com/spreadsheets/d/1EJMLr_MPrYiO1TKJ2MjNkR-fA5Wgxa782-f0Wtdpz0w/htmlview#

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'options'
require('lazy').setup('plugins', {
  install = { colorscheme = { 'ariake', 'aurora', 'habamax' } },
})
require 'autocommands'
require 'remaps'

if vim.g.neovide then
  require 'neovide'
else
  -- local setup = require('mini.hues').setup
  -- setup { background = '#29193d', foreground = '#ba85fa', accent = 'green' }
  -- next line is just to surpress a warning, if I keep using aurora as my colorscheme
  ---@diagnostic disable-next-line: missing-fields
  -- require("notify").setup({ background_colour = "#111111" })
  -- vim.cmd [[let g:aurora_transparent = 0]]
  -- vim.cmd [[let g:aurora_darker = 1]]
  -- vim.cmd [[colorscheme aurora]]
  -- vim.cmd [[hi! link MiniStatusLineModeNormal MiniStatusLineModeOther]]
  -- vim.cmd [[colorscheme nightfly]]
  -- vim.cmd [[colorscheme eldritch]]
  -- vim.cmd [[colorscheme ariake]]
  vim.cmd [[colorscheme tokyonight]]
end
