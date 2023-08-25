-- TODO:
-- 1. fix MiniAnimate.config.scroll so that the mousewheel works better
-- 2. think about whether I want to run zz after using n or N to go to the next match (and then adjust the animation)
--      See the commented remap in remap.lua for an example
-- 3. Decide how I want <cr> and <tab> to interact with the completion menu
-- 4. Make telekasten.toggle_todo work in visual mode
-- 5. Make luasnip work
-- 6. Set up whichkey
-- 7. Find a terminal program? And make it work with 'samjwill/nvim-unception'
-- 8. Add 'tpope/vim-fugitive'?
-- 9. Find a more purple colorscheme?
-- 10. Add a command to set the wd if opening with a file?


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("jwe.options")
require("lazy").setup("plugins")
require("jwe.remap")
require("jwe.lsp_setup")
-- require("jwe.miniclue")
require("jwe.plugin_setup")
require("jwe.autocommands")
