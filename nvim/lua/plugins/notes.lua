return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { 'markdown', 'Rmd' },
      code = {
        render_modes = { 'i' },
        style = 'full',
        border = 'thick',
      },
      html = {
        comment = {
          conceal = false,
        },
      },
    },
  },

  {
    -- "epwalsh/obsidian.nvim",
    'obsidian-nvim/obsidian.nvim',
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = 'work',
          path = vim.fn.expand '~/Documents/Work/OneDrive - Norwegian Refugee Council/notes',
        },
        {
          name = 'personal',
          path = vim.fn.expand '~/Documents/personal/notes',
          overrides = {
            templates = {
              folder = vim.NIL,
            },
            notes_subdir = vim.NIL,
          },
        },
      },
      new_notes_location = 'notes_subdir',
      notes_subdir = 'meetings',
      sort_by = 'path',

      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.date '%y%m%d') .. '-' .. suffix
      end,

      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = '' }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      templates = {
        folder = 'templates',
        date_format = '%Y-%m-%d-%a',
        time_format = '%H:%M',
      },
      disable_frontmatter = false,
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        vim.fn.jobstart { 'open', url } -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        -- vim.ui.open(url) -- need Neovim 0.10.0+
      end,
    },
  },
}
