require('mini.animate').setup()
require('mini.basics').setup()
require('mini.bracketed').setup()
require('mini.comment').setup()
require('mini.files').setup()
require('mini.jump2d').setup({ })
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

require('mini.indentscope').setup({
  options = {
    border = 'both',
    try_as_border = true,
  }
})

require('mini.jump').setup({
  mappings = {
    repeat_jump = ',',
  },
  delay = {
    idle_stop = 1000,
  }
})

require('mini.pairs').setup({
  mappings = {
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
  local buf_clients = vim.lsp.buf_get_clients()
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
    ministart.sections.sessions(5, true),
    ministart.sections.recent_files(10, false),
    ministart.sections.builtin_actions(),
  },
  content_hooks = {
    ministart.gen_hook.adding_bullet(),
    ministart.gen_hook.indexing(),
    ministart.gen_hook.aligning('center', 'center'),
  },
})
