local M = {}

function M.search_todos()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")
  local sorters = require("telescope.sorters")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local fn = vim.fn

  -- Run ripgrep
  local handle = io.popen("rg --no-heading --with-filename --line-number --column TODO")
  if not handle then
    print("Failed to run rg command")
    return
  end

  -- Group results
  local grouped = {}
  for line in handle:lines() do
    local filename, lnum, col, text = line:match("([^:]+):(%d+):(%d+):(.*)")
    if filename and lnum and col then
      local entry = {
        full = line,
        filename = filename,
        basename = fn.fnamemodify(filename, ":t"),
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = text,
      }
      grouped[filename] = grouped[filename] or {}
      table.insert(grouped[filename], entry)
    end
  end
  handle:close()

  -- Sort entries within each file
  for _, entries in pairs(grouped) do
    table.sort(entries, function(a, b)
      return a.lnum < b.lnum
    end)
  end

  -- Sort filenames by basename (reverse)
  local sorted_filenames = {}
  for fname in pairs(grouped) do
    table.insert(sorted_filenames, fname)
  end
  table.sort(sorted_filenames, function(a, b)
    return fn.fnamemodify(a, ":t") > fn.fnamemodify(b, ":t")
  end)

  -- Flatten to a list with header entries
  local results = {}
  for _, fname in ipairs(sorted_filenames) do
    table.insert(results, {
      is_header = true,
      filename = fname,
      basename = fn.fnamemodify(fname, ":t"),
    })

    for _, entry in ipairs(grouped[fname]) do
      table.insert(results, entry)
    end
  end

  -- Telescope display logic
  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = 6 }, -- line
      { remaining = true },
    },
  })

  local make_display = function(entry)
    if entry.is_header then
      local header_display = entry_display.create({
        separator = "",
        items = {
          { remaining = true },
        },
      })

      return header_display({
        { ">>  " .. entry.basename .. " (" .. entry.filename .. ")", "@markup.heading.1.markdown" },
      })
    end
    return displayer({
      tostring(entry.lnum),
      entry.text,
    })
  end

  -- Telescope picker
  pickers
    .new({}, {
      prompt_title = "TODOs (Grouped by Filename)",
      finder = finders.new_table({
        results = results,
        entry_maker = function(entry)
          if entry.is_header then
            return {
              display = make_display,
              ordinal = entry.basename,
              filename = entry.filename,
              basename = entry.basename,
              is_header = true,
              -- hl_group = "TelescopeMultiIcon", -- THIS DOES NOT SEEM TO WORK FIXME
            }
          else
            return {
              value = entry,
              ordinal = entry.text,
              display = make_display,
              filename = entry.filename,
              lnum = entry.lnum,
              text = entry.text,
            }
          end
        end,
      }),
      sorter = sorters.get_generic_fuzzy_sorter(),
      previewer = conf.grep_previewer({}),
      attach_mappings = function(bufnr, map)
        actions.select_default:replace(function()
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)

          if entry.is_header then
            return
          end

          vim.cmd(string.format("edit +%d %s", entry.lnum, entry.filename))
        end)
        return true
      end,
    })
    :find()
end

return M
