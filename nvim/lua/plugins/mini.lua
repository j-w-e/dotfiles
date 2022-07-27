local present, mini = pcall(require, "mini.sessions")

if not present then
    return
end

mini.setup({
        autowrite = false,
        directory = '~/.local/share/nvim/session',--<"session" subdir of user data directory from |stdpath()|>,
        file = '',
        force = { read = false, write = false, delete = false },
        verbose = { read = false, write = true, delete = true },
})
