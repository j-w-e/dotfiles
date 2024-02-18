require('mini.ai').setup()
require('mini.align').setup()
require('mini.animate').setup()
require('mini.comment').setup()
require('mini.cursorword').setup()
require('mini.files').setup()
-- require('mini.jump2d').setup({ })
require('mini.tabline').setup()
require('mini.trailspace').setup()

require('mini.basics').setup({
  mappings = {
      option_toggle_prefix = [[<leader>to]],
  },
})

require('mini.bracketed').setup({
  buffer     = { suffix = 'b', options = {} },
  comment    = { suffix = 'c', options = {} },
  conflict   = { suffix = 'x', options = {} },
  diagnostic = { suffix = 'd', options = {} },
  file       = { suffix = '' },
  indent     = { suffix = '' },
  jump       = { suffix = 'j', options = {} },
  location   = { suffix = 'l', options = {} },
  oldfile    = { suffix = '' },
  quickfix   = { suffix = 'q', options = {} },
  treesitter = { suffix = 't', options = {} },
  undo       = { suffix = '' },
  window     = { suffix = 'w', options = {} },
  yank       = { suffix = 'y', options = {} },
})
require('mini.hipatterns').setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
  },
})
require('mini.indentscope').setup({
  options = {
    border = 'both',
    try_as_border = true,
  }
})

-- require('mini.jump').setup({
--   mappings = {
--     repeat_jump = ',',
--   },
--   delay = {
--     idle_stop = 1000,
--   }
-- })

require('mini.pairs').setup({
  mappings = {
    -- ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%S][^%S]", register = { cr = false } },
    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%a]' },
    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%a]' },
    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%a]' },
    [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
    [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
  },
})
require('mini.sessions').setup({
  autowrite = false,
  directory = '~/.local/share/nvim/session',--<"session" subdir of user data directory from |stdpath()|>,
  file = 'dirSession.vim',
  force = { read = false, write = true, delete = false },
  verbose = { read = false, write = true, delete = true },
})

local ministatus = require("mini.statusline")

-- The following code is an attempt to get lsp and formatter to display in the status line.
-- It comes from this comment https://www.reddit.com/r/neovim/comments/xtynan/comment/iqtcq0s/?utm_source=share&utm_medium=web2x&context=3
Lsp = function()
  local buf_clients = vim.lsp.get_active_clients( { bufnr = 0} )
  -- local supported_formatters = require("null-ls.sources").get_available(vim.bo.filetype)
  local clients = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(clients, client.name)
    end
  end

  -- for _, client in pairs(supported_formatters) do
  --   table.insert(clients, client.name)
  -- end

  if #clients > 0 then
    return table.concat(clients, ", ")
  else
    return "no LS"
  end
end,

---@diagnostic disable-next-line: redundant-value
ministatus.setup({
  content = {
    active = function()
      local mode, mode_hl = ministatus.section_mode({ trunc_width = 120 })
      local git           = ministatus.section_git({ trunc_width = 75 })
      local diagnostics   = ministatus.section_diagnostics({ trunc_width = 75 })
      local filename      = ministatus.section_filename({ trunc_width = 140 })
      local fileinfo      = ministatus.section_fileinfo({ trunc_width = 120 })
      local location      = ministatus.section_location({ trunc_width = 75 })
      local lsp           = Lsp()
      local noice_mode   = require("noice").api.status.mode.get()

      return ministatus.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        -- { hl = 'MiniStatuslineFileinfo', strings = { noice_cmd, noice_mode } },
        { hl = 'MiniStatuslineFileinfo', strings = { noice_mode } },
        { hl = 'MiniStatuslineFilename', strings = { lsp } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { location } },
      })
    end,
  },
})

local ministart = require("mini.starter")
ministart.setup({
  evaluate_single = true,
  items = {
    ministart.sections.sessions(5, false),
    ministart.sections.recent_files(10, false),
    ministart.sections.builtin_actions(),
  },
  content_hooks = {
    ministart.gen_hook.adding_bullet(),
    ministart.gen_hook.indexing(),
    ministart.gen_hook.aligning('center', 'center'),
  },
})

  local list_patterns = {
    neorg_1 = "%-",
    neorg_2 = "%-%-",
    neorg_3 = "%-%-%-",
    neorg_4 = "%-%-%-%-",
    neorg_5 = "%-%-%-%-%-",
    unordered = "[-+*]", -- - + *
    digit = "%d+[.)]", -- 1. 2. 3.
    ascii = "%a[.)]", -- a) b) c)
    roman = "%u*[.)]", -- I. II. III.
    latex_item = "\\item",
  }
require('autolist').setup({
  lists = { -- configures list behaviours
    -- Each key in lists represents a filetype.
    -- The value is a table of all the list patterns that the filetype implements.
    -- See how to define your custom list below in the readme.
    -- You must put the file name for the filetype, not the file extension
    -- To get the "file name", it is just =:set filetype?= or =:se ft?=.
    markdown = {
      list_patterns.unordered,
      list_patterns.digit,
      list_patterns.ascii, -- for example this specifies activate the ascii list
      list_patterns.roman, -- type for markdown files.
    },
    telekasten = {
      list_patterns.unordered,
      list_patterns.digit,
      list_patterns.ascii,
      list_patterns.roman,
    },
    text = {
      list_patterns.unordered,
      list_patterns.digit,
      list_patterns.ascii,
      list_patterns.roman,
    },
  }
})

require('mini.surround').setup({
  mappings = {
    add = '<leader>msa', -- Add surrounding in Normal and Visual modes
    delete = '<leader>msd', -- Delete surrounding
    find = '<leader>msf', -- Find surrounding (to the right)
    find_left = '<leader>msF', -- Find surrounding (to the left)
    highlight = '<leader>msh', -- Highlight surrounding
    replace = '<leader>msr', -- Replace surrounding
    update_n_lines = '<leader>msn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
})

vim.cmd([[
let R_assign = 2
let R_rconsole_width = winwidth(0) / 2
autocmd VimResized * let R_rconsole_width = winwidth(0) / 2
]])
local setup = require('mini.hues').setup
setup({ background = '#29193d', foreground = '#ba85fa', accent = 'blue'})
-- next line is just to surpress a warning, if I keep using aurora as my colorscheme
require('notify').setup({ background_colour = '#111111' })
vim.cmd([[let g:aurora_transparent = 0]])
vim.cmd([[colorscheme aurora]])
