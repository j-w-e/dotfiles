return {
  { 'renerocksai/telekasten.nvim',
    dependencies = { 'L3MON4D3/LuaSnip' },
    config = function ()
      local ls = require("luasnip")
      ls.add_snippets("telekasten", {
        ls.snippet("see", {
          ls.text_node("see email from "),
          ls.insert_node(1, "Lian"),
          ls.text_node(", subject \'"),
          ls.insert_node(0),
          ls.text_node("\'"),
        })
      })
      ls.add_snippets("telekasten", {
        ls.snippet("link", {
          ls.text_node("["),
          ls.insert_node(1, "text"),
          ls.text_node("]("),
          ls.insert_node(0, ""),
          ls.text_node(")"),
        })
      })
      local telekasten = require('telekasten')
      telekasten.setup({
        home = vim.fn.expand("~/Documents/notes"),
        take_over_my_home = true,
        tag_notation = "#tag",
        dailies = vim.fn.expand("~/Documents/notes") .. '/' .. 'dailies',
        templates = vim.fn.expand("~/Documents/notes")  .. '/' .. 'templates',
        template_new_note = vim.fn.expand("~/Documents/notes")  .. '/' .. 'templates/new_note.md',
        template_new_daily =  vim.fn.expand("~/Documents/notes") .. '/' .. 'templates/new_daily_journal.md',
        template_new_weekly =  vim.fn.expand("~/Documents/notes") .. '/' .. 'templates/weeklies.md',
        show_tags_theme = "dropdown",
        journal_auto_open = true,
        -- telescope actions behavior
        close_after_yanking = true,
        insert_after_inserting = false,
        command_palette_theme = 'dropdown',
      })

    end
  }
}
