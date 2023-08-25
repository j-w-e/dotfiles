require('mini.animate').setup()
require('mini.basics').setup()
require('mini.comment').setup()
require('mini.files').setup()
require('mini.jump2d').setup({ })
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

require('mini.indentscope').setup({
  options = {
    border = 'top',
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

ministatus = require("mini.statusline")

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


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "r", "markdown", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

  },
}
