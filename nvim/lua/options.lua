vim.g.mapleader = " "
vim.g.maplocalleader = ' '

local o      = vim.o
o.showmode   = true
o.listchars  = 'extends:…,precedes:…,nbsp:␣,trail:·,tab:»·,eol:↲'
o.list       = true
o.expandtab  = true
o.shiftwidth = 2
o.tabstop		 = 2
o.scrolloff  = 12
o.number     = true
o.updatetime = 250
o.timeoutlen = 300
o.completeopt = 'menuone,noselect,longest'

vim.diagnostic.config({ severity_sort = true })