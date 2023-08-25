vim.opt.ts = 4
vim.opt.sw = 4

require('mini.indentscope').setup({
  options = {
    border = 'top',
    try_as_border = true,
  }
})
local k = vim.keymap.set

k("n", "<leader>na", "<cmd>lua require('telekasten').show_tags()<CR>", { desc = "show tags" })
k("n", "<leader>nb", "<cmd>lua require('telekasten').show_backlinks()<CR>", { desc = "show backlinks" })
k("n", "<leader>nd", "<cmd>lua require('telekasten').goto_today()<CR>", { desc = "go to today" })
k("n", "<leader>nf", "<cmd>lua require('telekasten').find_notes()<CR>", { desc = "find notes" })
k("n", "<leader>nh", "<cmd>lua require('telekasten').follow_link()<CR>", { desc = "follow link" })
k("n", "<leader>ni", "<cmd>lua require('telekasten').insert_link()<CR>", { desc = "insert link" })
k("n", "<leader>nn", "<cmd>lua require('telekasten').new_note()<CR>", { desc = "new note" })
k("n", "<leader>ns", "<cmd>lua require('telekasten').search_notes()<CR>", { desc = "search notes" })
k("n", "<leader>nt", "<cmd>lua require('telekasten').toggle_todo()<CR>", { desc = "toggle to do" })
k("n", "<leader>nw", "<cmd>lua require('telekasten').goto_thisweek()<CR>", { desc = "go to today" })
k("n", "<leader>ny", "<cmd>lua require('telekasten').yank_notelink()<CR>", { desc = "yank link to note" })
