vim.g.mapleader = " "

local o      = vim.o
o.showmode   = true
o.listchars  = 'extends:…,precedes:…,nbsp:␣,trail:·,tab:»·,eol:↲,multispace:   |'
o.list       = true
o.expandtab  = true
o.shiftwidth = 4
o.scrolloff  = 12
o.number     = true

vim.diagnostic.config({ severity_sort = true })
