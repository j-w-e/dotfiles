-- TODO:
-- 1. Add Hydras for git?
-- 2. Add a right-alt to my qmk and zmk keymaps, so I can then add a right alt to my ghostty config...
-- 3. ... so I can then have alt keybindings in ghostty and neovim...
-- 4. ... so that I can then find a good set of keymaps for:
--    5. ... make a line a bullet point
--    6. ... accept snippet completion?
--    6. ... join lines in markdown: https://linkarzu.com/posts/neovim/markdown-setup-2025/#delete-newlines-in-between-markdown-join
--    7. ... delete a file?
-- 8. Make markdown folding work properly. See https://linkarzu.com/posts/neovim/markdown-setup-2025/#fold-all-level-2-or-3-headings
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

-- local setup = require('mini.hues').setup
-- setup { background = '#29193d', foreground = '#ba85fa', accent = 'green' }
-- next line is just to surpress a warning, if I keep using aurora as my colorscheme
---@diagnostic disable-next-line: missing-fields
-- require("notify").setup({ background_colour = "#111111" })
vim.cmd [[colorscheme tokyonight]]
