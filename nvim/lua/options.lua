vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

local o       = vim.o
o.showmode    = true
o.listchars   = 'extends:…,precedes:…,nbsp:␣,trail:·,tab:»·,eol:↲'
o.list        = true
o.expandtab   = true
o.shiftwidth  = 4
o.tabstop     = 4
o.scrolloff   = 12
o.number      = true
o.updatetime  = 250
o.timeoutlen  = 300
o.completeopt = 'menuone,noselect,longest'
o.rnu         = true

vim.diagnostic.config({ severity_sort = true })
