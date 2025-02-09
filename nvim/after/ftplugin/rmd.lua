vim.opt_local.ts = 2
vim.opt_local.sw = 2
-- vim.cmd 'runtime! ftplugin/r.lua'
vim.opt_local.wrap = true
-- vim.opt_local.spell = true
vim.opt.conceallevel = 0
vim.b.miniindentscope_config = { options = { border = "top" } }

-- Remove the backtick from pairing, since this should be taken care of by r.nvim
vim.keymap.set("i", "`", "<Cmd>lua require('r.rmd').write_chunk()<CR>", { buffer = 0 })
