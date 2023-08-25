local k = vim.keymap.set

k("n",  "<leader>fe", "<cmd>lua MiniFiles.open()<cr>", { desc = "file tree" })
k("n", "<leader>ct", "<cmd>lua MiniTrailspace.trim()<cr>", { desc = "trim whitespace" })

k("n", "<leader>bn", "<cmd>bn<cr>", { desc = "next buffer" })
k("n", "<leader>bp", "<cmd>bp<cr>", { desc = "prev buffer" })
k("n", "<leader>bd", "<cmd>bd<cr>", { desc = "delete buffer" })
k("n", "<leader>fw", "<cmd>w<cr>", { desc = "save" })
k("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
k({ "n", "v" }, "<leader>i", require('nvim-toggler').toggle, { desc = "invert" })
k("n", "<leader>sn", "<cmd>noh<cr>", { desc = "no highlight" })
k("i", "<a-backspace>", "<c-w>", { desc = "delete word" })
k("c", "<a-backspace>", "<c-w>", { desc = "delete word" })
k("v", ">", ">gv", { desc = "indent" })
k("v", "<", "<gv", { desc = "de-indent" })

-- k("n", "n", "<cmd>lua vim.cmd('normal! n'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<cr>", { desc = "next match" })

local builtin = require('telescope.builtin')
k('n', '<leader>ff', builtin.find_files, { desc = "find files" })
k('n', '<leader>fr', builtin.oldfiles, { desc = "find files" })
k('n', '<leader>fg', builtin.git_files, { desc = "find git files" })
k('n', '<leader>sg', builtin.live_grep, { desc = "grep string" })
k('n', '<leader>tb', builtin.buffers, { desc = "find buffers" })
k('n', '<leader>th', builtin.help_tags, { desc = "help tags" })
k('n', '<leader>tm', "<cmd>Noice telescope<cr>", { desc = "message history" })
