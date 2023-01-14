vim.api.nvim_buf_set_keymap(0, "i", "%%", " %>% ", {})
vim.cmd[[
nmap <leader>h mzvai<Plug>RESendSelection<esc>`z
vmap <leader>h <Plug>RESendSelection<esc>
]]

-- failed attempts at configuring keymaps: 
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", "vai:RESendSelection", {desc = "send r text object"}) -- gives not an editor command '<,'>RESend...
-- vim.api.nvim_buf_set_keymap(0, "v", "<leader>h", ":RESendSelection<cr>", {desc = "send r text object"}) -- gives "not an editor command"
-- vim.api.nvim_buf_set_keymap(0, "v", "<leader>h", ":<Plug>RESendSelection<cr>", {desc = "send r text object"}) -- gives Trailing characters Plug>...
-- vim.api.nvim_buf_set_keymap(0, "v", "<leader>h", "vim.cmd[[<Plug>RDSendSelection]]", {desc = "send r text object"}) -- gives Trailing characters Plug>...

-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", "vai | :RESendSelection<cr>", {desc = "send r text object"}) -- gives not an editor command '<,'>RESend...
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", "vim.cmd[[vai | :<Plug>RDSendSelection]]", {desc = "send r text object"}) -- selects blank region...
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", "vim.cmd[[vai | :<Plug>RDSendSelection<cr>]]", {desc = "send r text object"}) -- selects blank region...
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>h", "vim.cmd[[ :call SendLineToR(\"stay\"<cr>)]]", {desc = "send r text object"}) -- selects blank region...


-- with vim.cmd
-- nmap <leader>h :call SendLineToR("stay")<cr> -- works
-- vmap <leader>h <Plug>RSendSelection -- also works
-- nmap <leader>h vai<Plug>REDSendSelection<esc> works but only goes down by only line
-- nmap <leader>h mzvai<Plug>REDSendSelection<esc>`z works to stay on current line

