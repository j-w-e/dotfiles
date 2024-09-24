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
nmap('<leader><space>', 'zz', 'zz')
map({ 'n', 'o' }, '`', "'")
map({ 'n', 'o' }, "'", '`')
wk.add {
  { "'", desc = '`', nowait = true },
  { '`', desc = "'", nowait = true },
}
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
-- nmap('<leader>n', require('telekasten').panel, 'show notes panel')

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

-- normal mode
wk.add({
  { '<esc>', '<cmd>noh<cr>', desc = 'remove search highlight' },
  { '[q', ':silent cprev<cr>', desc = 'quickfix prev' },
  { ']q', ':silent cnext<cr>', desc = 'quickfix next' },
  { 'gN', 'Nzzzv', desc = 'center search' },
  { 'gf', ':e <cfile><CR>', desc = 'edit file' },
  { 'n', 'nzzzv', desc = 'center search' },
  { 'z?', ':setlocal spell!<cr>', desc = 'toggle spellcheck' },
}, { mode = 'n' })

-- visual mode
wk.add({
  -- ['<cr>'] = { send_region, 'run code region' },
  -- ['<M-j>'] = { ":m'>+<cr>`<my`>mzgv`yo`z", 'move line down' },
  -- ['<M-k>'] = { ":m'<-2<cr>`>my`<mzgv`yo`z", 'move line up' },
  { '.', ':norm .<cr>', desc = 'repeat last normal mode command', mode = 'v' },
  { 'q', ':norm @q<cr>', desc = 'repeat q macro', mode = 'v' },
}, { mode = 'v' })

-- visual with <leader>
wk.add({
  { '<leader>d', '"_d', desc = 'delete without overwriting reg', mode = 'v' },
  { '<leader>p', '"_dP', desc = 'replace without overwriting reg', mode = 'v' },
}, { mode = 'v', prefix = '<leader>' })

-- nmap('<leader><cr>', send_cell)

-- normal mode with <leader>
wk.add({
  {
    { '<leader>c', group = '[c]ode / [c]ell / [c]hunk' },
    { '<leader>cn', ':split term://$SHELL<cr>', desc = '[n]ew terminal with shell' },
    { '<leader>co', group = '[o]open code chunk' },
    { '<leader>cp', ':split term://python<cr>', desc = 'new [p]ython terminal' },
    {
      '<leader>cr',
      function()
        vim.b['quarto_is_r_mode'] = true
        vim.cmd 'split term://R'
      end,
      desc = 'new [R] terminal',
    },
    { '<leader>d', group = '[d]ebug' },
    { '<leader>f', group = '[f]ind (telescope)' },
    { '<leader>fM', '<cmd>Telescope man_pages<cr>', desc = '[M]an pages' },
    { '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[b]uffer fuzzy find' },
    { '<leader>fc', '<cmd>Telescope git_commits<cr>', desc = 'git [c]ommits' },
    { '<leader>fd', '<cmd>Telescope buffers<cr>', desc = '[d] buffers' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[f]iles' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[g]rep' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = '[h]elp' },
    { '<leader>fj', '<cmd>Telescope jumplist<cr>', desc = '[j]umplist' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = '[k]eymaps' },
    { '<leader>fl', '<cmd>Telescope loclist<cr>', desc = '[l]oclist' },
    { '<leader>fm', '<cmd>Telescope marks<cr>', desc = '[m]arks' },
    { '<leader>fq', '<cmd>Telescope quickfix<cr>', desc = '[q]uickfix' },
    { '<leader>fr', require('telescope.builtin').oldfiles, desc = '[r]ecent files' },
    { '<leader>fs', '<cmd>Telescope lsp_document_symbols<cr>', desc = 'document [s]ymbols' },
    { '<leader>g', group = '[g]it' },
    -- { "<leader>gb", group = "[b]lame" },
    -- { "<leader>gbb", ":GitBlameToggle<cr>", desc = "[b]lame toggle virtual text" },
    -- { "<leader>gbc", ":GitBlameCopyCommitURL<cr>", desc = "[c]opy" },
    -- { "<leader>gbo", ":GitBlameOpenCommitURL<cr>", desc = "[o]pen" },
    { '<leader>gc', ':GitConflictRefresh<cr>', desc = '[c]onflict' },
    { '<leader>gd', group = '[d]iff' },
    { '<leader>gdc', ':DiffviewClose<cr>', desc = '[c]lose' },
    { '<leader>gdo', ':DiffviewOpen<cr>', desc = '[o]pen' },
    { '<leader>gs', ':Gitsigns<cr>', desc = 'git [s]igns' },
    {
      '<leader>gwc',
      ":lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
      desc = 'worktree create',
    },
    {
      '<leader>gws',
      ":lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
      desc = 'worktree switch',
    },
    { '<leader>l', group = '[l]anguage/lsp' },
    { '<leader>lD', vim.lsp.buf.type_definition, desc = 'type [D]efinition' },
    { '<leader>lR', desc = '[R]ename' },
    { '<leader>la', vim.lsp.buf.code_action, desc = 'code [a]ction' },
    { '<leader>le', vim.diagnostic.open_float, desc = 'diagnostics (show hover [e]rror)' },
    { '<leader>lg', ':Neogen<cr>', desc = 'neo[g]en docstring' },
    { '<leader>lr', '<cmd>Telescope lsp_references<cr>', desc = '[r]eferences' },
    { '<leader>ls', ':ls!<cr>', desc = '[l]ist all buffers' },
    { '<leader>o', group = 'notes' },
    { '<leader>on', '<cmd>ObsidianNewFromTemplate<cr>', desc = 'New note' },
    { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = 'Search notes' },
    { '<leader>oc', '<cmd>ObsidianToggleCheckbox<cr>', desc = 'Toggle checkbox' },
    { '<leader>or', '<cmd>ObsidianRename<cr>', desc = 'Rename note' },
    { '<leader>ot', '<cmd>ObsidianTags<cr>', desc = 'Search tags' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = 'Backlinks' },
    { '<leader>to', group = 'toggle' },
    {
      '<leader>tof',
      '<cmd>lua vim.b.disable_autoformat = not vim.b.disable_autoformat<cr>',
      desc = 'disable autoformat',
    },
    { '<leader>v', group = '[v]im' },
    { '<leader>vc', ':Telescope colorscheme<cr>', desc = '[c]olortheme' },
    { '<leader>vh', ':execute "h " . expand("<cword>")<cr>', desc = 'vim [h]elp for current word' },
    { '<leader>vl', ':Lazy<cr>', desc = '[l]azy package manager' },
    { '<leader>vm', ':Mason<cr>', desc = '[m]ason software installer' },
    { '<leader>vs', '<cmd>e $MYVIMRC<cr><cmd>lcd %:p:h<cr>', desc = '[s]ettings, edit vimrc' },
  },
}, { mode = 'n', prefix = '<leader>' })
