return {
  {
    'renerocksai/telekasten.nvim',
    dependencies = { 'L3MON4D3/LuaSnip' },
    config = function()
      local ls = require 'luasnip'
      ls.add_snippets('telekasten', {
        ls.snippet('see', {
          ls.text_node 'see email from ',
          ls.insert_node(1, 'Lian'),
          ls.text_node ", subject '",
          ls.insert_node(2),
          ls.text_node "'",
          ls.insert_node(0),
        }),
      })
      ls.add_snippets('telekasten', {
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
        home = vim.fn.expand '~/Documents/notes',
        take_over_my_home = true,
        tag_notation = '#tag',
        dailies = vim.fn.expand '~/Documents/notes' .. '/' .. 'dailies',
        templates = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates',
        template_new_note = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates/new_note.md',
        template_new_daily = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates/new_daily_journal.md',
        template_new_weekly = vim.fn.expand '~/Documents/notes' .. '/' .. 'templates/weeklies.md',
        show_tags_theme = 'dropdown',
        journal_auto_open = true,
        -- telescope actions behavior
        close_after_yanking = true,
        insert_after_inserting = false,
        command_palette_theme = 'dropdown',
      }
    end,
  },

  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    enabled = false,
    opts = {},
    -- opts = {
    --   markdown = {
    --     query = vim.treesitter.query.parse(
    --       "markdown",
    --       [[
    --             (atx_heading [
    --               (atx_h1_marker)
    --               (atx_h2_marker)
    --               (atx_h3_marker)
    --               (atx_h4_marker)
    --               (atx_h5_marker)
    --               (atx_h6_marker)
    --             ] @headline)
    --
    --             (thematic_break) @dash
    --
    --             (fenced_code_block) @codeblock
    --
    --             (block_quote_marker) @quote
    --             (block_quote (paragraph (inline (block_continuation) @quote)))
    --             (block_quote (paragraph (block_continuation) @quote))
    --             (block_quote (block_continuation) @quote)
    --             ]]
    --     ),
    --     headline_highlights = { "Headline" },
    --     -- bullet_highlights = {
    --     --   "@text.title.1.marker.markdown",
    --     --   "@text.title.2.marker.markdown",
    --     --   "@text.title.3.marker.markdown",
    --     --   "@text.title.4.marker.markdown",
    --     --   "@text.title.5.marker.markdown",
    --     --   "@text.title.6.marker.markdown",
    --     -- },
    --     bullets = {},
    --     -- codeblock_highlight = "CodeBlock",
    --     -- dash_highlight = "Dash",
    --     -- dash_string = "-",
    --     -- quote_highlight = "Quote",
    --     -- quote_string = "┃",
    --     -- fat_headlines = true,
    --     -- fat_headline_upper_string = "▃",
    --     -- fat_headline_lower_string = "🬂",
    --   },
    --   rmd = {
    --     query = vim.treesitter.query.parse(
    --       "markdown",
    --       [[
    --             (atx_heading [
    --               (atx_h1_marker)
    --               (atx_h2_marker)
    --               (atx_h3_marker)
    --               (atx_h4_marker)
    --               (atx_h5_marker)
    --               (atx_h6_marker)
    --             ] @headline)
    --
    --             (thematic_break) @dash
    --
    --             (fenced_code_block) @codeblock
    --
    --             (block_quote_marker) @quote
    --             (block_quote (paragraph (inline (block_continuation) @quote)))
    --             (block_quote (paragraph (block_continuation) @quote))
    --             (block_quote (block_continuation) @quote)
    --             ]]
    --     ),
    --     treesitter_language = "markdown",
    --     headline_highlights = { "String" },
    --     bullet_highlights = {
    --       "@text.title.1.marker.markdown",
    --       "@text.title.2.marker.markdown",
    --       "@text.title.3.marker.markdown",
    --       "@text.title.4.marker.markdown",
    --       "@text.title.5.marker.markdown",
    --       "@text.title.6.marker.markdown",
    --     },
    --     bullets = {},
    --     -- codeblock_highlight = "CodeBlock",
    --     -- dash_highlight = "Dash",
    --     -- dash_string = "-",
    --     -- quote_highlight = "Quote",
    --     -- quote_string = "┃",
    --     fat_headlines = false,
    --     fat_headline_upper_string = "▃",
    --     fat_headline_lower_string = "▔", -- Upper one eighth block
    --     -- fat_headline_lower_string = "▀", -- Upper one half block
    --   },
    --   quarto = {
    --     query = vim.treesitter.query.parse(
    --       "markdown",
    --       [[
    --             (atx_heading [
    --               (atx_h1_marker)
    --               (atx_h2_marker)
    --               (atx_h3_marker)
    --               (atx_h4_marker)
    --               (atx_h5_marker)
    --               (atx_h6_marker)
    --             ] @headline)
    --
    --             (thematic_break) @dash
    --
    --             (fenced_code_block) @codeblock
    --
    --             (block_quote_marker) @quote
    --             (block_quote (paragraph (inline (block_continuation) @quote)))
    --             (block_quote (paragraph (block_continuation) @quote))
    --             (block_quote (block_continuation) @quote)
    --             ]]
    --     ),
    --     treesitter_language = "markdown",
    --     headline_highlights = { "String" },
    --     bullet_highlights = {
    --       "@text.title.1.marker.markdown",
    --       "@text.title.2.marker.markdown",
    --       "@text.title.3.marker.markdown",
    --       "@text.title.4.marker.markdown",
    --       "@text.title.5.marker.markdown",
    --       "@text.title.6.marker.markdown",
    --     },
    --     bullets = {},
    --     codeblock_highlight = "CodeBlock",
    --     -- dash_highlight = "Dash",
    --     -- dash_string = "-",
    --     -- quote_highlight = "Quote",
    --     -- quote_string = "┃",
    --     fat_headlines = false,
    --     fat_headline_upper_string = "▃",
    --     fat_headline_lower_string = "▔", -- Upper one eighth block
    --     -- fat_headline_lower_string = "▀", -- Upper one half block
    --   },
    --   telekasten = {
    --     query = vim.treesitter.query.parse(
    --       "markdown",
    --       [[
    --             (atx_heading [
    --               (atx_h1_marker)
    --               (atx_h2_marker)
    --               (atx_h3_marker)
    --               (atx_h4_marker)
    --               (atx_h5_marker)
    --               (atx_h6_marker)
    --             ] @headline)
    --
    --             (thematic_break) @dash
    --
    --             (fenced_code_block) @codeblock
    --
    --             (block_quote_marker) @quote
    --             (block_quote (paragraph (inline (block_continuation) @quote)))
    --             (block_quote (paragraph (block_continuation) @quote))
    --             (block_quote (block_continuation) @quote)
    --             ]]
    --     ),
    --     treesitter_language = "markdown",
    --     headline_highlights = { "String" },
    --     bullet_highlights = {
    --       "@text.title.1.marker.markdown",
    --       "@text.title.2.marker.markdown",
    --       "@text.title.3.marker.markdown",
    --       "@text.title.4.marker.markdown",
    --       "@text.title.5.marker.markdown",
    --       "@text.title.6.marker.markdown",
    --     },
    --     bullets = {},
    --     -- codeblock_highlight = "CodeBlock",
    --     -- dash_highlight = "Dash",
    --     -- dash_string = "-",
    --     -- quote_highlight = "Quote",
    --     -- quote_string = "┃",
    --     fat_headlines = false,
    --     fat_headline_upper_string = "▃",
    --     fat_headline_lower_string = "▔", -- Upper one eighth block
    --     -- fat_headline_lower_string = "▀", -- Upper one half block
    --   },
    -- },
  },
}
