local map = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, { silent = true, desc = desc })
end
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { silent = true, desc = desc })
end

-- map({ 'n', 'v' }, '<Space>', '<Nop>', "leader")

-- Basic navigation / usage
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("i", "<a-backspace>", "<c-w>", "delete word")
map("c", "<a-backspace>", "<c-w>", "delete word")
map("v", ">", ">gv", "indent")
map("v", "<", "<gv", "de-indent")
nmap('<leader>tm', "<cmd>Noice telescope<cr>", "message history")
nmap('<leader>vs', MiniStarter.open, "show start screen")
nmap('<leader>vl', "<cmd>Lazy<cr>", "show Lazy")
nmap('<leader>vm', "<cmd>Mason<cr>", "show Mason")

-- Files
nmap("<leader>fe", "<cmd>lua MiniFiles.open()<cr>", "file tree")
nmap("<leader>fw", "<cmd>w<cr>", "save")
nmap("<leader>q", "<cmd>q<cr>", "quit")

-- Terminal
-- (I don't know if I need both of these mapppings in each context, but I think there might be 
-- a problem with remapping esc in the terminal?)
nmap("<c-,>", require('FTerm').open, "open float term")
nmap("<leader>,", require('FTerm').open, "open float term")
map('t', '<esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
map('t', '<c-,>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Searching
local builtin = require('telescope.builtin')
nmap('<leader>ff', builtin.find_files, "find files")
nmap('<leader>fr', builtin.oldfiles, "find recent files")
nmap('<leader>fg', builtin.git_files, "find git files")
nmap('<leader>sg', builtin.live_grep, "grep string")
nmap('<leader>tb', builtin.buffers, "find buffers")
nmap('<leader>sh', builtin.help_tags, "search help")
nmap('<leader>/', builtin.current_buffer_fuzzy_find, "find in current buffer")
nmap('<leader>sw', builtin.grep_string, "search current word")
nmap('<leader>sd', builtin.diagnostics, "search diagnostics")
nmap("<leader>sn", "<cmd>noh<cr>", "no highlight")

-- Windows / buffers
nmap("<leader>bn", "<cmd>bn<cr>", "next buffer")
nmap("<leader>bp", "<cmd>bp<cr>", "prev buffer")
nmap("<leader>bd", "<cmd>bd<cr>", "delete buffer")
nmap("<leader>ws", "<cmd>sp<cr>", "horz split")
nmap("<leader>wv", "<cmd>vs<cr>", "vert split")
nmap("<c-h>", "<C-w>h", "focus left window")
nmap("<c-j>", "<C-w>j", "focus below window")
nmap("<c-k>", "<C-w>k", "focus above window")
nmap("<c-l>", "<C-w>l", "focus right window")

-- map({"n", "v"}, "n", "<cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<cr>", "next match" )

-- Code
nmap("<leader>cm", "<cmd>make<cr>", "make")
map({ "n", "v" }, "<leader>i", require('nvim-toggler').toggle, "invert")
nmap("<leader>ct", "<cmd>lua MiniTrailspace.trim()<cr>", "trim whitespace")
-- diagnostic keymaps
-- nmap('<leader>e', vim.diagnostic.open_float, "Open floating diagnostic message")
-- nmap('<leader>q', vim.diagnostic.setloclist, "Open diagnostics list")

-- Notes
nmap("<leader>n", require('telekasten').panel, "show notes panel")
