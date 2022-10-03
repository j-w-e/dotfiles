-- local keymap = vim.api.nvim_set_keymap
vim.api.nvim_buf_set_keymap(0, "n", "<leader>rf", "<cmd>IronRepl<cr>", {desc = "start repl"})
