local api = vim.api

-- show cursorline only in active window
local cursorGroup = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd(
    { "InsertLeave", "WinEnter" },
    { pattern = "*", command = "set cursorline", group = cursorGroup }
)
api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGroup }
)
