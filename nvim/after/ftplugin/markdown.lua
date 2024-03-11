vim.opt_local.ts   = 4
vim.opt_local.sw   = 4
vim.opt_local.wrap = true
vim.opt_local.conceallevel = 2

-- Using Bullets.vim
vim.cmd[[nmap <leader>rn <Plug>(bullets-renumber)]]
vim.cmd[[vmap <leader>rn <Plug>(bullets-renumber)]]

vim.cmd[[
au BufEnter * syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")\ze\_s" keepend contained conceal contains=markdownUrl concealends
au BufEnter * hi link tkLink markdownLinkText
]]

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
