-- 7. work out how to implement "which_key_ignore" as a key description for mappings
-- 14. configure lsp. again see v3. including setting omnifunc to a sensible keymappings. and enable document formatting if I can?
-- 15. think about whether c-n, c-p, c-y and c-e are good enough for wildmenu, or whether i need to implement https://vi.stackexchange.com/questions/22627/switching-arrow-key-mappings-for-wildmenu-tab-completion 
-- 18. Bindings ideas:
--      * move window? 
--      * space space and arrows to shift between windows?
--      * nvim-r bindings which conflict with ripgrep for example
-- 19. get R completion working. 
--      * matmarqs alsmost works. see https://github.com/matmarqs/dotfiles/blob/10c1820158d7736081d978b459e030e4ca6a9330/house/.config/nvim/init.lua. What does not work is the menu opening automatically
-- 20. make sure I've imported all the sensible settings from my various branches, such as the ability to resume editing at a the most recent point 
-- 21. set up a session to work in R
-- 23. add trailspace keymaps
-- 24. fix the which key keymaps, and then the lsp. 
-- 25. fix the jump settings so that I can jump to a specific word and not just the line start

-- PACKER setup {{{1
-- packer blah {{{2
local fn = vim.fn
-- Automatically install packer on initial startup
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    Packer_Bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print "---------------------------------------------------------"
    print "Press Enter to install packer and plugins."
    print "After install -- close and reopen Neovim to load configs!"
    print "---------------------------------------------------------"
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand to reload neovim when you save plugins.lua
vim.cmd [[
   augroup packer_user_config
   autocmd!
   autocmd BufWritePost init.lua source <afile> | PackerSync
   autocmd BufEnter init.lua set fdm=marker
   augroup end
]]

-- Use a protected call
local present, packer = pcall(require, "packer")

if not present then
    return
end
-- plugin calls {{{2
packer.startup(function(use)
    use 'wbthomason/packer.nvim'           -- packer manages itself 
    use 'nvim-lua/plenary.nvim'            -- avoids callbacks, used by other plugins
    --use 'nvim-lua/popup.nvim'              -- popup for other plugins
    use 'nvim-treesitter/nvim-treesitter'  -- language parsing completion engine
    use 'williamboman/nvim-lsp-installer'  -- UI for fetching/downloading LSPs
    use 'neovim/nvim-lspconfig'            -- language server protocol implementation
    --use 'hrsh7th/nvim-cmp'                 -- THE vim completion engine
    --use 'L3MON4D3/LuaSnip'                 -- more snippets
    --use 'saadparwaiz1/cmp_luasnip'         -- even more snippets
    --use 'hrsh7th/cmp-nvim-lsp'
    --use 'hrsh7th/cmp-buffer'
    --use 'hrsh7th/cmp-path'
    use 'nvim-telescope/telescope.nvim'    -- finder, requires fzf and ripgrep
    use 'kyazdani42/nvim-tree.lua'
    --use 'jose-elias-alvarez/null-ls.nvim' -- see https://www.youtube.com/watch?v=b7OguLuaYvE
    use 'jalvesaq/Nvim-R'
    use 'kyazdani42/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    use 'echasnovski/mini.nvim'
    --use 'JoseConseco/telescope_sessions_picker.nvim'
    use { 'j-w-e/telescope_sessions_picker.nvim', branch = 'devel' }
    use 'folke/which-key.nvim'

    if Packer_Bootstrap then
        require('packer').sync()
    end
end)

-- all settings {{{1
-- whichkey {{{2
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local present, whichkey = pcall(require, "which-key")

if present then
    whichkey.setup({
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "  ", -- symbol used between a key and it's label
            group = "+ ", -- symbol prepended to a group
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
            b = { "<cmd>Telescope buffers<cr>", "buffer list" },
            q = { "<cmd>lua MiniBufremove.delete()<cr>", "del buffer" },
            d = { "<cmd>lua MiniBufremove.delete(0, true)<cr>", "really del buffer!" },
            n = { "<cmd>bn<cr>", "next buffer" },
            p = { "<cmd>bp<cr>", "prev buffer" },
        },
        c = {
            name = "code",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code actions" },
            f = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "format" },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
        },
        D = { "go to type def" },
        e = { "open float" },
        f = {
            name = "file",
            r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
            n = { "<cmd>enew<cr>", "new file" },
            e = { "edit file" },
            f = { "<cmd>Telescope find_files<cr>", "find files" },
            w = { "<cmd>w<cr>", "save" },
            wq = { "<cmd>wq<cr>", "save-and-quit" },
        },
        g = {
            name = "go to",
            r = { "<cmd>lua vim.lsp.buf.references()<cr>", "references" }
        },
        n = { "<cmd>NvimTreeToggle<cr>", "nvim-tree" },
        p = {
            name = "packer",
            s = { "<cmd>PackerSync<cr>", "sync" },
            c =  { "<cmd>PackerClean<cr>", "clean" },
        },
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
            l = { "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<cr>", "jump to letter" },
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
end
-- keymaps {{{2

-- keymap("n", "<leader>rg", "<cmd>Telescope live_grep<cr>", opts)

keymap("t", "<esc>", "<c-\\><c-n>", opts)
keymap("n", "<c-j>", "<cmd>set paste<cr>m`o<esc>``<cmd>set nopaste<cr>", opts)
keymap("n", "<c-k>", "<cmd>set paste<cr>m`O<esc>``<cmd>set nopaste<cr>", opts)
keymap("i", "<a-backspace>", "<c-w>", opts)
keymap("c", "<a-backspace>", "<c-w>", opts)

-- local function smart_d_visual()
--     local l, c = unpack(vim.api.nvim_win_get_cursor(0))
--     for _, line in ipairs(vim.api.nvim_buf_get_lines(0, l - 1, l, true)) do
--         if line:match("^%s*$") then
--             return "\"_d"
--         end
--     end
--     return "d"
-- end
local function smart_d_normal()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return "\"_dd"
    else
        return "dd"
    end
end

-- vim.keymap.set("v", "d", smart_d_visual, { noremap = true, expr = true } )
vim.keymap.set("n", "dd", smart_d_normal, { noremap = true, expr = true } )



-- standard options {{{2
local g = vim.g
local opt = vim.opt

g.netrw_banner = 0
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.ruler = false
opt.cursorline = true
opt.signcolumn = 'yes:2'
opt.scrolloff = 12
opt.mouse = 'a'
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.showmode = false
opt.wildmode = "longest:full,full"
opt.list = true
opt.listchars = "trail:·,tab:»·,eol:↲,multispace:   |,extends:>,precedes:<"
opt.timeoutlen = 500

-- autocommands {{{2
-- show cursorline only in active window
local cursorGroup = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
    { "InsertLeave", "WinEnter" },
    { pattern = "*", command = "set cursorline", group = cursorGroup }
)
vim.api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGroup }
)

-- PLUGIN CONFIG {{{1


-- general {{{2
-- gitsigns {{{3

local present, gitsigns = pcall(require, "gitsigns")

if present then
    gitsigns.setup({ })
end

-- lsp {{{3

local present, lspconfig = pcall(require, "lspconfig")

if present then
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        -- Hugh's note to self: line above could end v:lua.MiniCompletion.completefunc_lsp
        -- see `h mini.completion`
        local vim_version = vim.version()

        if vim_version.minor > 7 then
            -- nightly
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        else
            -- stable
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
        end

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        --removed the following, because I am unlikely to use them. 
        --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        --vim.keymap.set('n', '<space>wl', function()
        --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, bufopts)
        --moved the following to whichkey instead
        --vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        --vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        --vim.keymap.set('n', '<space>cf', vim.lsp.buf.formatting, bufopts)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,

        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    }

    lspconfig.r_language_server.setup ({
        on_attach = on_attach,
    })
end

-- nvim-tree {{{3

local present, nvimtree = pcall(require, "nvim-tree")

if present then
    nvimtree.setup({ })
end

-- nvim-treesitter {{{3

local present, nvimtreesitter = pcall(require, "nvim-treesitter")

if present then
    nvimtreesitter.setup({ 
        ensure_installed = { "lua", "r", "c" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            disable = {  },

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        },
    })
end

-- telescope {{{2

local present, telescope = pcall(require, "telescope")

if present then

    telescope.setup{
        defaults = {
            layout_strategy = 'horizontal',
            layout_config = { prompt_position = "top" },
            sorting_strategy = 'ascending',
        },
        pickers = {
            sessions_picker = {
                sessions_dir = vim.fn.stdpath('data') ..'/session/',  -- same as '/home/user/.local/share/nvim/session'
            },
            extensions = { }
        }}
    telescope.load_extension('sessions_picker')
end

-- Mini {{{2
-- colors {{{3

local present, minibase = pcall(require, "mini.base16")

if present then
    --local palette = minibase.mini_palette( '#29193d', '#9d6fd5' )
    local palette = minibase.mini_palette( '#1e122d', '#9d6fd5' )
    minibase.setup({
        palette = palette
    })
    vim.cmd[[ 
        hi MiniStatuslineDevinfo guibg=#2f283a 
        hi MiniStatuslineFileinfo guibg=#2f283a
        hi MiniTrailspace guibg=#1e122d guifg=#595363
    ]]
    -- vim.cmd [[hi link MiniTrailspace Comment]] 
end

-- bufremove {{{3

local present, minibuf = pcall(require, "mini.bufremove")

if present then
    minibuf.setup()
end 

-- comment {{{3

local present, minicomment = pcall(require, "mini.comment")

if present then
    minicomment.setup()
end

-- completion {{{3

local present, minicomp = pcall(require, "mini.completion")

if present then 
    minicomp.setup({
        mappings = {
            force_twostep = '<A-Space>',
        }
    })
    local keys = {
        ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
        ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
        ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
    }

    vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
    vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })

    _G.cr_action = function()
        if vim.fn.pumvisible() ~= 0 then
            -- If popup is visible, confirm selected item or add new line otherwise
            local item_selected = vim.fn.complete_info()['selected'] ~= -1
            return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
        else
            -- If popup is not visible, use plain `<CR>`. You might want to customize
            -- according to other plugins. For example, to use 'mini.pairs', replace
            -- next line with `return require('mini.pairs').cr()`
            return require('mini.pairs').cr()
            --return keys['cr']
        end
    end

  vim.api.nvim_set_keymap('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })
end

-- jump {{{3

local present, minijump = pcall(require, "mini.jump")

if present then
    minijump.setup({
        mappings = {
            repeat_jump = ',',
        }
    })
end


-- jump2d {{{3

local present, minijump2d = pcall(require, "mini.jump2d")

if present then
    local jump_line_start = minijump2d.builtin_opts.line_start
    minijump2d.setup({
        labels = 'aeichtsnkruoybldwvjxgmfp',
        allowed_lines = {
            cursor_at = false,
        },
        spotter = jump_line_start.spotter,
        hooks = { after_jump = jump_line_start.hooks.after_jump }
    })
end
-- pairs
local present, minipairs = pcall(require, "mini.pairs")

if present then 
    minipairs.setup({
    })
end

-- sessions {{{3
local present, minisessions = pcall(require, "mini.sessions")

if present then
    minisessions.setup({
        autowrite = false,
        directory = '~/.local/share/nvim/session',--<"session" subdir of user data directory from |stdpath()|>,
        file = 'dirSession.vim',
        force = { read = false, write = false, delete = false },
        verbose = { read = false, write = true, delete = true },
    })
end

-- starter {{{3
local present, ministart = pcall(require, "mini.starter")

if present then 
    ministart.setup({
        evaluate_single = true,
        items = {
            ministart.sections.sessions(5, true),
            ministart.sections.recent_files(10, false),
            ministart.sections.builtin_actions(),
        },
        content_hooks = {
            ministart.gen_hook.adding_bullet(),
            ministart.gen_hook.indexing(),
            ministart.gen_hook.aligning('center', 'center'),
        },
    })
end



-- statusline {{{3
local present, ministatus = pcall(require, "mini.statusline")

if present then 
    ministatus.setup({ })
end


-- surround {{{3
local present, minisurround = pcall(require, "mini.surround")

if present then 
    minisurround.setup({ })
end

-- tabline {{{3
local present, minitab = pcall(require, "mini.tabline")

if present then 
    minitab.setup({ })
end


-- trailspace {{{3
local present, minitrail = pcall(require, "mini.trailspace")

if present then 
    minitrail.setup({ })
end


