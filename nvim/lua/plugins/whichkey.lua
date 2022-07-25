local present, whichkey = pcall(require, "which-key")

if not present then
  return
end

whichkey.setup({
   icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "  ", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
   },

   popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
   },

   window = {
      border = "single", -- none/single/double/shadow
   },

   layout = {
      spacing = 6, -- spacing between columns
   },

   key_labels = {
        ["<space>"] = "<spc>",
   },

   hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

   triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      i = { "j", "k" },
      v = { "j", "k" },
   },
})

whichkey.register({
    b = {
        name = "buffer",
        b = { "buffer list" },
        q = { "<cmd>Bdelete<cr>", "del buffer" },
        d = { "<cmd>Bdelete!<cr>", "really del buffer!" },
    },
    c = {
        name = "code", 
        a = "code actions",
        f = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "format" },
    },
    D = { "go to type def" },
    e = { "open float" },
    f = {
        name = "file",
        r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
        n = { "<cmd>enew<cr>", "new file" },
        e = { "edit file" },
        f = { "find files" },
        w = { "<cmd>w<cr>", "save" },
        wq = { "<cmd>wq<cr>", "save-and-quit" },
    },
    n = { "<cmd>NvimTreeToggle<cr>", "nvim-tree" },
    q = { "<cmd>q<cr>", "quit" },
    r = {
        name = "rename",
        g = "grep", 
        n = "smart rename",
    },
    s = {
        name = "search",
        n = { "<cmd>noh<cr>", "no highlight" },
        t = { "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending layout_config={\"prompt_position\":\"top\"}<cr>", "find in current buf" },
        w = { "<cmd>HopWord<cr>", "hop-word" },
        l = { "<cmd>HopLine<cr>", "hop-line" },
    },
    t = { "<cmd>Telescope<cr>", "telescope" },
    v = {
        name = "vim config", 
        e = { "<cmd>e ~/.config/nvim/init.lua<cr>", "edit init.lua" },
        p = { "<cmd>e ~/.config/nvim/lua/plugins.lua<cr>", "edit plugins.lua" },
        r = { "<cmd>luafile ~/.config/nvim/init.lua<cr>", "reload init.lua" },
    },
    w = {
        name = "window", 
        v = { "<cmd>vs<cr>", "vertical split" },
        s = { "<cmd>sp<cr>", "split" },
        c = { "<cmd>clo<cr>", "close" },
        h = { "<c-w>h", "go to win left" },
        j = { "<c-w>j", "go to win down" },
        k = { "<c-w>k", "go to win up" },
        l = { "<c-w>l", "go to win right" },
    },
}, { prefix = "<leader>" })
