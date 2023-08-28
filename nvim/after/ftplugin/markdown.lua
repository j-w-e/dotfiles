vim.opt_local.ts = 4
vim.opt_local.sw = 4

vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")

-- functions to recalculate list on edit
vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
