vim.opt_local.ts = 2
vim.opt_local.sw = 2

-- vim.keymap.set('i', '%%', ' %>% ', { buffer = 0 })
-- vim.keymap.set('i', '<c-,>', ' |>', { buffer = 0 })
-- -- vim.keymap.set('n', '<leader>rr', '<cmd>RMapsDesc<cr>', { buffer = 0, desc = 'R mappings' })

MiniPairs.map_buf(
  0,
  "i",
  "'",
  { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\#].", register = { cr = false } }
)
