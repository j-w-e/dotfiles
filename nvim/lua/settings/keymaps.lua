local opts = { noremap = true, silent = true }

-- Shorten keymap nvim call
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes:
--   Normal       = "n"
--   Insert       = "i"
--   Visual       = "v"
--   Visual_Block = "x"
--   Terminal     = "t"
--   Command      = "c"

--keymap("n", "<leader>v", ":Vex<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>rg", "<cmd>Telescope live_grep<cr>", opts)

--Hugh's custom keymap settings
--keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", opts)
keymap("t", "<esc>", "<c-\\><c-n>", opts)
keymap("n", "<c-j>", "<cmd>set paste<cr>m`o<esc>``<cmd>set nopaste<cr>", opts)
keymap("n", "<c-k>", "<cmd>set paste<cr>m`O<esc>``<cmd>set nopaste<cr>", opts)
keymap("n", "H", "<cmd>BufferLineCyclePrev<cr>", opts)
keymap("n", "L", "<cmd>BufferLineCycleNext<cr>", opts)
vim.cmd([[nnoremap , <Plug>(clever-f-repeat-forward)]])
vim.cmd([[nnoremap ; <Plug>(clever-f-repeat-back)]])
keymap("n", "<c-n>", "<c-w>h", opts)
keymap("n", "<c-e>", "<c-w>j", opts)
keymap("n", "<c-i>", "<c-w>k", opts)
keymap("n", "<c-o>", "<c-w>l", opts)
keymap("i", "<c-n>", "<c-w>h", opts)
keymap("i", "<c-e>", "<c-w>j", opts)
keymap("i", "<c-i>", "<c-w>k", opts)
keymap("i", "<c-o>", "<c-w>l", opts)
-- hop set-up
-- vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
-- vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
-- vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })<cr>", {})
-- vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })<cr>", {})

local function smart_d_visual()
	local l, c = unpack(vim.api.nvim_win_get_cursor(0))
	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, l - 1, l, true)) do
		if line:match("^%s*$") then
			return "\"_d"
		end
	end
	return "d"
end
local function smart_d_normal()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return "\"_dd"
  else
    return "dd"
  end
end

vim.keymap.set("v", "d", smart_d_visual, { noremap = true, expr = true } )
vim.keymap.set("n", "dd", smart_d_normal, { noremap = true, expr = true } )
