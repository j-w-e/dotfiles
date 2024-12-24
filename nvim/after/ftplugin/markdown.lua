vim.opt_local.ts = 4
vim.opt_local.sw = 4
vim.opt_local.wrap = true
vim.opt_local.conceallevel = 2

-- Using Bullets.vim
-- vim.keymap.set({ 'n', 'v' }, '<leader>rn', '<Plug>(bullets-renumber)', { buffer = 0 })
vim.keymap.set('i', '<cr>', '<Plug>(bullets-newline)', { buffer = 0 })
vim.keymap.set('n', 'o', '<Plug>(bullets-newline)', { buffer = 0 })
vim.keymap.set('i', '<C-t>', '<Plug>(bullets-demote)', { buffer = 0 })
vim.keymap.set('n', '>>', '<Plug>(bullets-demote)', { buffer = 0 })
vim.keymap.set('v', '>', '<Plug>(bullets-demote)', { buffer = 0 })
vim.keymap.set('i', '<C-d>', '<Plug>(bullets-promote)', { buffer = 0 })
vim.keymap.set('n', '<<', '<Plug>(bullets-promote)', { buffer = 0 })
vim.keymap.set('v', '<', '<Plug>(bullets-promote)', { buffer = 0 })

-- local nmap = function(keys, func, desc)
--   vim.keymap.set("n", keys, func, { silent = true, desc = desc, buffer = 0 })
-- end
-- nmap("<leader>nf", "<cmd>lua require('telescope.builtin').find_files({cwd = 'current'})<cr>", "find files in current")
-- nmap("<leader>nt", "<cmd>lua require('telekasten').find_notes()<cr>", "use telekasten picker")

vim.cmd [[
au BufEnter * syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")\ze\_W" keepend contained conceal contains=markdownUrl concealends
au BufEnter * hi link tkLink markdownLinkText
]]

---@diagnostic disable-next-line: inject-field
vim.b.minisurround_config = {
  custom_surroundings = {
    s = {
      input = { '%~%~().-()%~%~' },
      output = { left = '~~', right = '~~' },
    },
    i = {
      input = { '%*().-()%*' },
      output = { left = '*', right = '*' },
    },
    b = {
      input = { '%*%*().-()%*%*' },
      output = { left = '**', right = '**' },
    },
  },
}

vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt_local.foldlevelstart = 99
vim.opt_local.foldlevel = 99

local ls = require 'luasnip'
ls.add_snippets('markdown', {
  ls.snippet('see', {
    ls.text_node 'see email from ',
    ls.insert_node(1, 'Lian'),
    ls.text_node ", subject '",
    ls.insert_node(2),
    ls.text_node "'",
    ls.insert_node(0),
  }),
  ls.snippet('here', {
    ls.text_node '[here](',
    ls.insert_node(1),
    ls.text_node ')',
    ls.insert_node(0),
  }),
  ls.snippet('thisdoc', {
    ls.text_node '[this document](',
    ls.insert_node(1),
    ls.text_node ')',
    ls.insert_node(0),
  }),
})
