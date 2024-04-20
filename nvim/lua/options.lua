vim.g.mapleader = ' '
vim.g.maplocalleader = vim.api.nvim_replace_termcodes('<BS>', false, false, true)

local o = vim.o
o.showmode = true
o.listchars = 'extends:…,precedes:…,nbsp:␣,trail:·,tab:»·,eol:↲'
o.list = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.scrolloff = 12
o.number = true
o.updatetime = 250 -- for autocommands and hovers
o.timeoutlen = 300 -- until which-key pops up
o.completeopt = 'menuone,noselect,noinsert,longest'
o.rnu = true
o.termguicolors = true

-- smarter search
o.ignorecase = true
o.smartcase = true

-- indent
o.smartindent = true
o.breakindent = true

-- diagnostics
vim.diagnostic.config {
  severity_sort = true,
  virtual_text = true,
  underline = true,
  signs = true,
}

-- enable autoformat?
vim.b.disable_autoformat = true

vim.cmd [[let g:bullets_set_mappings = 0]]
