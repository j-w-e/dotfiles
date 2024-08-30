local wk = require 'which-key'

vim.g['quarto_is_r_mode'] = nil
vim.g['reticulate_running'] = false

local map = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, { silent = true, desc = desc, noremap = true })
end
local imap = function(key, effect)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true })
end
local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { silent = true, desc = desc, noremap = true })
end

-- map({ 'n', 'v' }, '<Space>', '<Nop>', "leader")

-- Basic navigation / usage
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, noremap = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, noremap = true })
map('i', '<a-backspace>', '<c-w>', 'delete word')
map('c', '<a-backspace>', '<c-w>', 'delete word')
map('v', '>', '>gv', 'indent')
map('v', '<', '<gv', 'de-indent')
nmap('<leader>tm', '<cmd>Noice telescope<cr>', 'message history')
nmap('<leader>vs', MiniStarter.open, 'show start screen')
nmap('<leader>vl', '<cmd>Lazy<cr>', 'show Lazy')
nmap('<leader>vm', '<cmd>Mason<cr>', 'show Mason')
nmap('<leader><space>', 'zt', 'zt')
nmap('<leader>j', 'zz', 'zz')
wk.register({
  name = 'marks',
  ['`'] = "'",
  ["'"] = '`',
}, { nowait = true })
nmap('<leader>.', '<cmd>ZenMode<cr>', 'ZenMode')
nmap('x', '"_x', 'delete to black hole')
map('v', 'x', '"_x', 'delete to black hole')
nmap('<leader>c.', '@:', 'repeat last cmd')

-- Files
nmap('<leader>fe', '<cmd>lua MiniFiles.open()<cr>', 'file tree')
nmap('<leader>fw', '<cmd>w<cr>', 'save')
nmap('<leader>x', '<cmd>q<cr>', 'quit')
nmap('<leader>X', '<cmd>qa!<cr>', 'really quit')

-- Terminal
-- (I don't know if I need both of these mapppings in each context, but I think there might be
-- a problem with remapping esc in the terminal?)
nmap('<c-,>', require('FTerm').open, 'open float term')
nmap('<leader>,', require('FTerm').open, 'open float term')
map('t', '<esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
map('t', '<c-,>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- Searching
local builtin = require 'telescope.builtin'
nmap('<leader>ff', builtin.find_files, 'find files')
nmap('<leader>fr', builtin.oldfiles, 'find recent files')
nmap('<leader>fg', builtin.git_files, 'find git files')
nmap('<leader>sg', builtin.live_grep, 'grep string')
nmap('<leader>t<space>', builtin.buffers, 'find buffers')
nmap('<leader>sh', builtin.help_tags, 'search help')
nmap('<leader>/', builtin.current_buffer_fuzzy_find, 'find in current buffer')
nmap('<leader>sw', builtin.grep_string, 'search current word')
nmap('<leader>sd', builtin.diagnostics, 'search diagnostics')
nmap('<leader>sn', '<cmd>noh<cr>', 'no highlight')
nmap('<leader>tt', '<cmd>Telescope<cr>', 'open Telescope')
nmap('<leader>vp', '<cmd>Telescope lazy_plugins<cr>', 'lazy_plugins')
nmap('<leader>tr', '<cmd>Telescope resume<cr>', 'Telescope resume')

-- Windows / buffers
nmap('<leader>bn', '<cmd>bn<cr>', 'next buffer')
nmap('<leader>bp', '<cmd>bp<cr>', 'prev buffer')
nmap('<leader>bd', '<cmd>bd<cr>', 'delete buffer')
nmap('<leader>bx', '<cmd>bd!<cr>', 'force delete buffer')
nmap('<leader>ws', '<cmd>sp<cr>', 'horz split')
nmap('<leader>wv', '<cmd>vs<cr>', 'vert split')
nmap('<c-h>', '<C-w>h', 'focus left window')
nmap('<c-j>', '<C-w>j', 'focus below window')
nmap('<c-k>', '<C-w>k', 'focus above window')
nmap('<c-l>', '<C-w>l', 'focus right window')
-- Resize window using <shift> arrow keys
nmap('<S-Up>', '<cmd>resize +2<CR>')
nmap('<S-Down>', '<cmd>resize -2<CR>')
nmap('<S-Left>', '<cmd>vertical resize -2<CR>')
nmap('<S-Right>', '<cmd>vertical resize +2<CR>')

-- Git
-- nmap(']n', '<cmd>Gitsigns next_hunk<cr>', 'Next git hunk')
-- nmap('[n', '<cmd>Gitsigns prev_hunk<cr>', 'Prev git hunk')

-- map({"n", "v"}, "n", "<cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<cr>", "next match" )

-- Code
nmap('<leader>cm', '<cmd>make<cr>', 'make')
map({ 'n', 'v' }, '<leader>i', require('nvim-toggler').toggle, 'invert')
nmap('<leader>ct', '<cmd>lua MiniTrailspace.trim()<cr>', 'trim whitespace')
nmap('<leader>cd', '<cmd>lcd %:p:h<cr>', 'lcd to file')
-- diagnostic keymaps
-- nmap('<leader>e', vim.diagnostic.open_float, "Open floating diagnostic message")
-- nmap('<leader>q', vim.diagnostic.setloclist, "Open diagnostics list")

-- Notes
nmap('<leader>n', require('telekasten').panel, 'show notes panel')

-- Add undo break-points
imap(',', ',<c-g>u')
imap('.', '.<c-g>u')
imap(';', ';<c-g>u')

-- yank
nmap('<leader>y', '<cmd>YankBank<cr>', 'yankbank')
-- -- yank ring
-- vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
-- vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
-- vim.keymap.set('n', '<c-f>', '<Plug>(YankyCycleForward)')
-- vim.keymap.set('n', '<c-b>', '<Plug>(YankyCycleBackward)')
-- vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
-- nmap('<leader>ty', '<cmd>lua require("telescope").extensions.yank_history.yank_history()<cr>', 'search current word')

-- Smart dd
vim.keymap.set('n', 'dd', function()
  if vim.fn.getline '.' == '' then
    return '"_dd'
  end
  return 'dd'
end, { expr = true })

nmap('g,', 'g;', 'prev change')
nmap('g;', 'g,', 'next change')

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
--- TODO: incorpoarate this into quarto-nvim plugin
--- such that QuartoRun functions get the same capabilities
-- local function send_cell()
-- if vim.b['quarto_is_r_mode'] == nil then
--   vim.fn['slime#send_cell']()
--   return
-- end
-- if vim.b['quarto_is_r_mode'] == true then
--   vim.g.slime_python_ipython = 0
--   local is_python = require('otter.tools.functions').is_otter_language_context 'python'
--   if is_python and not vim.b['reticulate_running'] then
--     vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
--     vim.b['reticulate_running'] = true
--   end
--   if not is_python and vim.b['reticulate_running'] then
--     vim.fn['slime#send']('exit' .. '\r')
--     vim.b['reticulate_running'] = false
--   end
--   vim.fn['slime#send_cell']()
-- end
-- end

--- Send code to terminal with vim-slime
--- If an R terminal has been opend, this is in r_mode
--- and will handle python code via reticulate when sent
--- from a python chunk.
-- local slime_send_region_cmd = ':<C-u>call slime#send_op(visualmode(), 1)<CR>'
-- slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
-- local function send_region()
--   -- if filetyps is not quarto, just send_region
--   if vim.bo.filetype ~= 'quarto' or vim.b['quarto_is_r_mode'] == nil then
--     vim.cmd('normal' .. slime_send_region_cmd)
--     return
--   end
--   if vim.b['quarto_is_r_mode'] == true then
--     vim.g.slime_python_ipython = 0
--     local is_python = require('otter.tools.functions').is_otter_language_context 'python'
--     if is_python and not vim.b['reticulate_running'] then
--       vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
--       vim.b['reticulate_running'] = true
--     end
--     if not is_python and vim.b['reticulate_running'] then
--       vim.fn['slime#send']('exit' .. '\r')
--       vim.b['reticulate_running'] = false
--     end
--     vim.cmd('normal' .. slime_send_region_cmd)
--   end
-- end

-- send code with ctrl+Enter
-- just like in e.g. RStudio
-- needs kitty (or other terminal) config:
-- map shift+enter send_text all \x1b[13;2u
-- map ctrl+enter send_text all \x1b[13;5u
-- nmap('<c-cr>', send_cell)
-- nmap('<s-cr>', send_cell)
-- imap('<c-cr>', send_cell)
-- imap('<s-cr>', send_cell)

--- Show R dataframe in the browser
-- might not use what you think should be your default web browser
-- because it is a plain html file, not a link
-- see https://askubuntu.com/a/864698 for places to look for
-- local function show_r_table()
--   local node = vim.treesitter.get_node { ignore_injections = false }
--   local text = vim.treesitter.get_node_text(node, 0)
--   local cmd = [[call slime#send("DT::datatable(]] .. text .. [[)" . "\r")]]
--   vim.cmd(cmd)
-- end

local is_code_chunk = function()
  local current, _ = require('otter.keeper').get_current_language_context()
  if current then
    return true
  else
    return false
  end
end

--- Insert code chunk of given language
--- Splits current chunk if already within a chunk
--- @param lang string
local insert_code_chunk = function(lang)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
  local keys
  if is_code_chunk() then
    keys = [[o```<cr><cr>```{]] .. lang .. [[}<esc>o]]
  else
    keys = [[o```{]] .. lang .. [[}<cr>```<esc>O]]
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

local insert_r_chunk = function()
  insert_code_chunk 'r'
end

local insert_py_chunk = function()
  insert_code_chunk 'python'
end

-- normal mode
wk.register({
  ['<esc>'] = { '<cmd>noh<cr>', 'remove search highlight' },
  ['n'] = { 'nzzzv', 'center search' },
  ['gN'] = { 'Nzzzv', 'center search' },
  ['gf'] = { ':e <cfile><CR>', 'edit file' },
  [']q'] = { ':silent cnext<cr>', 'quickfix next' },
  ['[q'] = { ':silent cprev<cr>', 'quickfix prev' },
  ['z?'] = { ':setlocal spell!<cr>', 'toggle spellcheck' },
}, { mode = 'n', silent = true })

-- visual mode
wk.register({
  -- ['<cr>'] = { send_region, 'run code region' },
  -- ['<M-j>'] = { ":m'>+<cr>`<my`>mzgv`yo`z", 'move line down' },
  -- ['<M-k>'] = { ":m'<-2<cr>`>my`<mzgv`yo`z", 'move line up' },
  ['.'] = { ':norm .<cr>', 'repat last normal mode command' },
  ['q'] = { ':norm @q<cr>', 'repat q macro' },
}, { mode = 'v' })

-- visual with <leader>
wk.register({
  p = { '"_dP', 'replace without overwriting reg' },
  d = { '"_d', 'delete without overwriting reg' },
}, { mode = 'v', prefix = '<leader>' })

-- insert mode
wk.register({
  ['<m-->'] = { ' <- ', 'assign' },
  ['<m-m>'] = { ' |> ', 'pipe' },
  ['<m-i>'] = { insert_r_chunk, 'r code chunk' },
  -- ['<cm-i>'] = { insert_py_chunk, 'python code chunk' },
  -- ['<m-I>'] = { insert_py_chunk, 'python code chunk' },
  ['<c-x><c-x>'] = { '<c-x><c-o>', 'omnifunc completion' },
}, { mode = 'i' })

-- nmap('<leader><cr>', send_cell)

-- normal mode with <leader>
wk.register({
  -- ['<cr>'] = { send_cell, 'run code cell' },
  c = {
    name = '[c]ode / [c]ell / [c]hunk',
    -- c = { ':SlimeConfig<cr>', 'slime [c]onfig' },
    n = { ':split term://$SHELL<cr>', '[n]ew terminal with shell' },
    r = {
      function()
        vim.b['quarto_is_r_mode'] = true
        vim.cmd 'split term://R'
      end,
      'new [R] terminal',
    },
    p = { ':split term://python<cr>', 'new [p]ython terminal' },
    o = {
      name = '[o]open code chunk',
    },
  },
  d = {
    name = '[d]ebug',
  },
  f = {
    name = '[f]ind (telescope)',
    f = { '<cmd>Telescope find_files<cr>', '[f]iles' },
    h = { '<cmd>Telescope help_tags<cr>', '[h]elp' },
    k = { '<cmd>Telescope keymaps<cr>', '[k]eymaps' },
    r = { require('telescope.builtin').oldfiles, '[r]ecent files' },
    g = { '<cmd>Telescope live_grep<cr>', '[g]rep' },
    b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', '[b]uffer fuzzy find' },
    m = { '<cmd>Telescope marks<cr>', '[m]arks' },
    M = { '<cmd>Telescope man_pages<cr>', '[M]an pages' },
    c = { '<cmd>Telescope git_commits<cr>', 'git [c]ommits' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'document [s]ymbols' },
    d = { '<cmd>Telescope buffers<cr>', '[d] buffers' },
    q = { '<cmd>Telescope quickfix<cr>', '[q]uickfix' },
    l = { '<cmd>Telescope loclist<cr>', '[l]oclist' },
    j = { '<cmd>Telescope jumplist<cr>', '[j]umplist' },
  },
  g = {
    name = '[g]it',
    c = { ':GitConflictRefresh<cr>', '[c]onflict' },
    s = { ':Gitsigns<cr>', 'git [s]igns' },
    wc = { ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", 'worktree create' },
    ws = { ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", 'worktree switch' },
    d = {
      name = '[d]iff',
      o = { ':DiffviewOpen<cr>', '[o]pen' },
      c = { ':DiffviewClose<cr>', '[c]lose' },
    },
    b = {
      name = '[b]lame',
      b = { ':GitBlameToggle<cr>', '[b]lame toggle virtual text' },
      o = { ':GitBlameOpenCommitURL<cr>', '[o]pen' },
      c = { ':GitBlameCopyCommitURL<cr>', '[c]opy' },
    },
  },
  -- h = {
  --   name = '[h]elp / [h]ide / debug',
  --   c = {
  --     name = '[c]onceal',
  --     h = { ':set conceallevel=1<cr>', '[h]ide/conceal' },
  --     s = { ':set conceallevel=0<cr>', '[s]how/unconceal' },
  --   },
  --   t = {
  --     name = '[t]reesitter',
  --     t = { vim.treesitter.inspect_tree, 'show [t]ree' },
  --   },
  -- },
  -- i = {
  --   name = '[i]nsert',
  --   i = { ':PasteImage<cr>', '[i]mage from clipboard' },
  -- },
  l = {
    name = '[l]anguage/lsp',
    r = { '<cmd>Telescope lsp_references<cr>', '[r]eferences' },
    R = { '[R]ename' },
    D = { vim.lsp.buf.type_definition, 'type [D]efinition' },
    a = { vim.lsp.buf.code_action, 'codr [a]ction' },
    e = { vim.diagnostic.open_float, 'diagnostics (show hover [e]rror)' },
    g = { ':Neogen<cr>', 'neo[g]en docstring' },
    s = { ':ls!<cr>', '[l]ist all buffers' },
  },
  o = {
    name = '[o]tter & c[o]de',
    a = { require('otter').dev_setup, 'otter [a]ctivate' },
    c = { 'O# %%<cr>', 'magic [c]omment code chunk # %%' },
    r = { insert_r_chunk, '[r] code chunk' },
    p = { insert_py_chunk, '[p]ython code chunk' },
  },
  -- q = {
  --   name = '[q]uarto',
  --   a = { ':QuartoActivate<cr>', '[a]ctivate' },
  --   p = { ":lua require'quarto'.quartoPreview()<cr>", '[p]review' },
  --   q = { ":lua require'quarto'.quartoClosePreview()<cr>", '[q]uit preview' },
  --   h = { ':QuartoHelp ', '[h]elp' },
  --   -- r = {
  --   --   name = '[r]un',
  --   --   r = { ':QuartoSendAbove<cr>', 'to cu[r]sor' },
  --   --   a = { ':QuartoSendAll<cr>', 'run [a]ll' },
  --   --   b = { ':QuartoSendBelow<cr>', 'run [b]elow' },
  --   -- },
  --   e = { ":lua require'otter'.export()<cr>", '[e]xport' },
  --   E = { ":lua require'otter'.export(true)<cr>", '[E]xport with overwrite' },
  -- },
  -- r = {
  --   name = '[r] R specific tools',
  --   t = { show_r_table, 'show [t]able' },
  -- },
  t = {
    o = {
      name = 'toggle',
      f = { '<cmd>lua vim.b.disable_autoformat = not vim.b.disable_autoformat<cr>', 'disable autoformat' },
    },
  },
  v = {
    name = '[v]im',
    c = { ':Telescope colorscheme<cr>', '[c]olortheme' },
    l = { ':Lazy<cr>', '[l]azy package manager' },
    m = { ':Mason<cr>', '[m]ason software installer' },
    s = { '<cmd>e $MYVIMRC<cr><cmd>lcd %:p:h<cr>', '[s]ettings, edit vimrc' },
    -- s = { ':e $MYVIMRC | :cd %:p:h | split . | wincmd k<cr>', '[s]ettings, edit vimrc' },
    h = { ':execute "h " . expand("<cword>")<cr>', 'vim [h]elp for current word' },
  },
  -- x = {
  --   name = 'e[x]ecute',
  --   x = { ':w<cr>:source %<cr>', '[x] source %' },
  -- },
}, { mode = 'n', prefix = '<leader>' })
