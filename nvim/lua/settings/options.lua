local g = vim.g
local opt = vim.opt

-- No Netrw Banner (remove this line if you're into that sort of thing)
g.netrw_banner = 0
-- Colors
opt.termguicolors = true
-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
-- Line Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.ruler = false


-- older settings from previous vim setup
opt.cursorline = true
opt.signcolumn = 'yes:2'
opt.scrolloff = 12
opt.mouse = 'a'
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.showmode = false
opt.wildmode = "longest:full,full"
opt.list = true
opt.listchars = "trail:·,tab:»·,eol:↲,multispace:   |,extends:>,precedes:<"

-- vim settings specifically for whichkey
opt.timeoutlen = 500
