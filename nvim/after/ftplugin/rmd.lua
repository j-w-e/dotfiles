-- require('cmp').setup({
--   sources = require('cmp').config.sources({
--     { name = 'luasnip', },
--     { name = 'cmp_nvim_r' },
--     { name = 'path', },
--     { name = 'buffer', },
--     })
-- })

vim.keymap.set('i', '%%', ' %>% ', { buffer = 0 })
vim.opt_local.wrap = true
