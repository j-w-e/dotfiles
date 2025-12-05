vim.opt_local.ts = 4
vim.opt_local.sw = 4
vim.opt_local.wrap = true
vim.opt_local.conceallevel = 2
vim.opt_local.iskeyword = '@,48-57,_,192-255,-'

-- -- The following is supposed to unmap gO from being "show outline of current buffer"
-- -- But just generates an error
-- vim.cmd [[ unmap <buffer> gO ]]

vim.b.miniindentscope_config = { options = { border = 'top' } }

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
-- vim.keymap.set('i', '<tab>', '<Plug>(bullets-demote)', { buffer = 0 })
-- vim.keymap.set('i', '<s-tab>', '<Plug>(bullets-promote)', { buffer = 0 })

-- vim.keymap.set('v', '<leader>ox', ':w !prettier --parser markdown | pandoc -o /tmp/tmp.docx && open /tmp/tmp.docx<cr>', { buffer = 0 })
-- stylua: ignore start
vim.keymap.set(
  "n",
  "<leader>ox",
  -- Ideally, this would also run the -e 's/\\sa0/\\fs22 \\sa0/' substitution as well, but the second \ doesn't get added, for some reason
  "<cmd>%w !prettier --parser markdown | pandoc -t rtf -s | sed 's/Helvetica/Aptos/' | pbcopy<cr>",
  { buffer = 0, desc = "Export buffer to clipboard"}
)
-- stylua: ignore end
vim.keymap.set(
  'v',
  '<leader>ox',
  -- ":!prettier --parser markdown | pandoc -t rtf -s | sed -e 's/Helvetica/Aptos/'<cr>",
  ":w !prettier --parser markdown | pandoc -t rtf -s | sed -e 's/Helvetica/Aptos/' | pbcopy<cr>",
  -- ":w !prettier --parser markdown | pandoc -t rtf -s | sed -e 's/\\sa0/\\fs22 \\sa0/' -e 's/Helvetica/Aptos/'<cr>",
  -- ":w !prettier --parser markdown | pandoc -t rtf -s | sed -e 's/sa0/sa0 \\fs22/' -e 's/Helvetica/Aptos/'<cr>",
  { buffer = 0, desc = 'Export selection to clipboard' }
)

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

vim.keymap.set('n', 'gss', 'gsairs', { buffer = 0, desc = 'strikeout current line', remap = true })

-- From https://github.com/obsidian-nvim/obsidian.nvim/wiki/Folding
-- This is supposed to allow heading folding, using <cr>
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo.foldmethod = 'expr'
-- vim.opt_local.foldmethod = 'expr'
-- vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt_local.foldlevelstart = 99
-- vim.opt_local.foldlevel = 99

vim.opt_local.nrformats = 'blank'

-- local j = function()
--   if vim.v.count == 1 then
--     print("count of 1")
--     return "gj"
--   end
--   if not vim.v.count then
--     vim.notify("no count")
--     return "gj"
--   end
--   vim.notify("just sending k", "error")
--   return "k" -- .. '^'
--   -- return vim.v.count .. 'k' -- .. '^'
-- end
-- vim.keymap.set("n", "j", j, { expr = true, buffer = 0 })
--
--
--

local action = '<BS><BS><Esc>[s1z=gi<Right>'
require('mini.keymap').map_combo('i', 'kk', action)
