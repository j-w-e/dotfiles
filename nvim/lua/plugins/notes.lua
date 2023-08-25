return {
  { 'renerocksai/telekasten.nvim',
  config = function ()
    local present, ls = pcall(require, "luasnip")
    if present then
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
      end
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

        vim.keymap.set("n", "<leader>n", "<cmd>lua require('telekasten').panel()<CR>", { desc = "show notes panel" })

        -- local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
        -- ft_to_parser.telekasten = "markdown" -- the someft filetype will use the python parser and queries.
    end
  }
}
