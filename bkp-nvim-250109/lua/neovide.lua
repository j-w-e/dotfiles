local setup = require('mini.hues').setup
setup { background = '#29193d', foreground = '#ba85fa', accent = 'purple' }

vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 5
vim.g.neovide_padding_right = 5
vim.g.neovide_padding_left = 5

vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_scroll_animation_far_lines = 10

vim.g.neovide_floating_shadow = false

vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_unfocused_outline_width = 0.125

vim.g.neovide_cursor_vfx_mode = ''

vim.g.neovide_scale_factor = 1.0

-- Neovide keymaps
if vim.g.neovide then
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<c-r>"') -- Paste insert mode
end
