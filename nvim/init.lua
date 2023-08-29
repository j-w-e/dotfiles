-- TODO:
-- 1. fix MiniAnimate.config.scroll so that the mousewheel works better
-- 2. think about whether I want to run zz after using n or N to go to the next match (and then adjust the animation)
--      See the commented remap in remap.lua for an example
-- 3. Decide how I want <cr> and <tab> to interact with the completion menu
-- 4. Make telekasten.toggle_todo work in visual mode
-- 8. Add 'tpope/vim-fugitive'?
-- 9. Find a more purple colorscheme?
-- 10. Add a command to set the wd if opening with a file?
-- 11. Set up a formatter?
-- 12. Think about switching to epwalsh/obsidian.nvim
-- 13. this link gives some useful info about default mappings: https://docs.google.com/spreadsheets/d/1EJMLr_MPrYiO1TKJ2MjNkR-fA5Wgxa782-f0Wtdpz0w/htmlview#
-- 14. fix ftplugin so that it calls markdown from telekasten, rather than repeating the code
-- 15. test whether my conditions in mini.pairs are correct

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

require("options")
require('lazy').setup("plugins")
require("autocommands")
require("core_setup")
require("ui_setup")
require("remaps")
