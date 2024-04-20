vim.cmd("runtime! ftplugin/markdown.lua")

local has_mini_indent, _ = pcall(require, "mini.indentscope")
if has_mini_indent then
  ---@diagnostic disable-next-line: inject-field
  vim.b.miniindentscope_config = {
    options = {
      border = "top",
      try_as_border = true,
    },
  }
end

local nmap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, desc = desc, buffer = 0 })
end

nmap("<leader>na", "<cmd>lua require('telekasten').show_tags()<CR>", "show tags")
nmap("<leader>nb", "<cmd>lua require('telekasten').show_backlinks()<CR>", "show backlinks")
nmap("<leader>nd", "<cmd>lua require('telekasten').goto_today()<CR>", "go to today")
nmap("<leader>nf", "<cmd>lua require('telekasten').find_notes()<CR>", "find notes")
nmap("<leader>nh", "<cmd>lua require('telekasten').follow_link()<CR>", "follow link")
nmap("<leader>ni", "<cmd>lua require('telekasten').insert_link()<CR>", "insert link")
nmap("<leader>nn", "<cmd>lua require('telekasten').new_note()<CR>", "new note")
nmap("<leader>ns", "<cmd>lua require('telekasten').search_notes()<CR>", "search notes")
nmap("<leader>nt", "<cmd>lua require('telekasten').toggle_todo()<CR>", "toggle to do")
nmap("<leader>nw", "<cmd>lua require('telekasten').goto_thisweek()<CR>", "go to today")
nmap("<leader>ny", "<cmd>lua require('telekasten').yank_notelink()<CR>", "yank link to note")
