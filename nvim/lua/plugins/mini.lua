local present, mini = pcall(require, "mini.sessions")

if not present then
   return
end

mini.setup({
	-- Whether to read latest session if Neovim opened without file arguments
	autoread = false,

	-- Whether to write current session before quitting Neovim
	autowrite = false,

	-- Directory where global sessions are stored (use `''` to disable)
	directory = '~/.local/share/nvim/session',--<"session" subdir of user data directory from |stdpath()|>,

	-- File for local session (use `''` to disable)
	file = '',

	-- Whether to force possibly harmful actions (meaning depends on function)
	force = { read = false, write = true, delete = false },

	-- Whether to print session path after action
	verbose = { read = false, write = true, delete = true },
})
