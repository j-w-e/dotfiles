-- telekasten config
local ls = require 'luasnip'
ls.add_snippets('markdown', {
  ls.snippet('see', {
    ls.text_node 'see email from ',
    ls.insert_node(1, 'Lian'),
    ls.text_node ", subject '",
    ls.insert_node(2),
    ls.text_node "'",
    ls.insert_node(0),
  }),
})
ls.add_snippets('markdown', {
  ls.snippet('link', {
    ls.text_node '[',
    ls.insert_node(1, 'text'),
    ls.text_node '](',
    ls.insert_node(2, ''),
    ls.text_node ')',
    ls.insert_node(0),
  }),
})
local telekasten = require 'telekasten'
telekasten.setup {
  -- home = vim.fn.expand("~/Documents/Work/OneDrive - Norwegian Refugee Council/notes/current"),
  -- home = vim.fn.expand("~/Documents/personal/notes"),
  -- home = vim.fn.expand("~/Documents/new_notes"),
  take_over_my_home = true,
  tag_notation = '#tag',
  show_tags_theme = 'dropdown',
  journal_auto_open = true,
  -- telescope actions behavior
  close_after_yanking = true,
  insert_after_inserting = false,
  default_vault = 'new_nrc',
  vaults = {
    new_nrc = {
      command_palette_theme = 'dropdown',
      home = vim.fn.expand '~/Documents/Work/OneDrive - Norwegian Refugee Council/notes/current',
      -- dailies = home .. "/" .. "dailies",
      -- templates = home .. "/" .. "templates",
      -- template_new_note = home .. "/" .. "templates/new_note.md",
      -- template_new_daily = home .. "/" .. "templates/new_daily_journal.md",
      -- template_new_weekly = home .. "/" .. "templates/weeklies.md",
    },
    archive = {
      home = vim.fn.expand '~/Documents/Work/OneDrive - Norwegian Refugee Council/notes/archive/',
    },
    meetings = {
      home = vim.fn.expand '~/Documents/Work/OneDrive - Norwegian Refugee Council/notes/meetings/',
    },
    nrc = {
      home = vim.fn.expand '~/Documents/notes',
      dailies = vim.fn.expand '~/Documents/notes' .. '/' .. 'dailies',
      templates = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates',
      template_new_note = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates/new_note.md',
      template_new_daily = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates/new_daily_journal.md',
      template_new_weekly = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates/weeklies.md',
    },
    personal = {
      home = vim.fn.expand '~/Documents/personal/notes',
    },
  },
}

-- mkdnflow config
require('mkdnflow').setup {
  modules = {
    bib = false,
    buffers = true,
    conceal = false,
    cursor = true,
    folds = true,
    links = true,
    lists = true,
    maps = true,
    paths = true,
    tables = true,
    yaml = false,
    cmp = false,
  },
  filetypes = { md = true, markdown = true, rmd = false },
  create_dirs = true,
  perspective = {
    priority = 'root',
    fallback = 'current',
    root_tell = 'index.md',
    nvim_wd_heel = false,
  },
  wrap = false,
  silent = false,
  cursor = { -- to match both markdown and wiki links
    jump_patterns = {
      '%b[]%b()',
      '<[^<>]->',
      '%b[] ?%b[]',
      '%[@[^%[%]]-%]',
      '%[%[[^%[%]]-%]%]',
    },
  },
  links = {
    style = 'wiki',
    name_is_source = true,
    conceal = true,
    implicit_extension = 'md',
    -- transform_implicit = false,
    transform_implicit = function(text)
      text = text:gsub('^%s*(.-)%s*$', '%1')
      text = text:gsub(' ', '_')
      text = text:lower()
      -- text = os.date('%Y-%m-%d_') .. text
      if text:match 'meeting' then
        return ('meetings/' .. text)
      else
        return ('current/' .. text)
      end
    end,
    transform_explicit = false,
    -- transform_explicit = function(text)
    --   text = text:gsub(" ", "-")
    --   text = text:lower()
    --   text = os.date('%Y-%m-%d_') .. text
    --   return (text)
    -- end
  },
  new_file_template = {
    template = [[
# {{ title }}
Date: {{ date }}
]],
    use_template = true,
    placeholders = {
      before = {
        date = 'os_date',
        title = ('link_title'):gsub('^%s*(.-)%s*$', '%1'),
      },
      after = {},
    },
  },
  mappings = {
    MkdnEnter = { { 'n', 'v' }, '<CR>' },
    MkdnTab = false,
    MkdnSTab = false,
    MkdnNextLink = { 'n', '<Tab>' },
    MkdnPrevLink = { 'n', '<S-Tab>' },
    MkdnNextHeading = { 'n', ']]' },
    MkdnPrevHeading = { 'n', '[[' },
    MkdnGoBack = { 'n', '<BS>' },
    MkdnGoForward = { 'n', '<Del>' },
    MkdnCreateLink = false, -- see MkdnEnter
    MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>p' }, -- see MkdnEnter
    MkdnFollowLink = false, -- see MkdnEnter
    MkdnDestroyLink = { 'n', '<M-CR>' },
    MkdnTagSpan = { 'v', '<M-CR>' },
    MkdnMoveSource = { 'n', '<F2>' },
    MkdnYankAnchorLink = { 'n', 'yaa' },
    MkdnYankFileAnchorLink = { 'n', 'yfa' },
    MkdnIncreaseHeading = { 'n', '+' },
    MkdnDecreaseHeading = { 'n', '-' },
    MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
    MkdnNewListItem = false,
    MkdnNewListItemBelowInsert = { 'n', 'o' },
    MkdnNewListItemAboveInsert = { 'n', 'O' },
    MkdnExtendList = false,
    MkdnUpdateNumbering = { 'n', '<leader>rn' },
    MkdnTableNextCell = { 'i', '<Tab>' },
    MkdnTablePrevCell = { 'i', '<S-Tab>' },
    MkdnTableNextRow = false,
    MkdnTablePrevRow = false,
    MkdnTableNewRowBelow = false,
    MkdnTableNewRowAbove = false,
    MkdnTableNewColAfter = false,
    MkdnTableNewColBefore = false,
    MkdnFoldSection = { 'n', '<leader>r' },
    MkdnUnfoldSection = { 'n', '<leader>m' },
  },
}
