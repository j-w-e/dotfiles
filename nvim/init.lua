-- 14. configure lsp. again see v3. including setting omnifunc to a sensible keymappings. and enable document formatting if I can?
-- 15. think about whether c-n, c-p, c-y and c-e are good enough for wildmenu, or whether i need to implement https://vi.stackexchange.com/questions/22627/switching-arrow-key-mappings-for-wildmenu-tab-completion
-- 18. Bindings ideas:
--      * move window?
--      * space space and arrows to shift between windows?
-- 21. set up a session to work in R
-- 24. fix the which key keymaps, and then the lsp.
-- 25. use keymap.desc to make sure I have whichkey descriptsiont for everything. see :h nvim_set_keymap()
-- 26. fix smart_d_visual so that it doesn't send a deletion to the black-hole buffer if the current line is blank, even if other lines are not blank. 
-- 27. tweaks to make telekasten work better:
--      * add a template for new notes
--      * see if I can work out a way to categorise meeting notes easily
--      * disable most snippets
--      * write something that automatically populates a list of references to a tag?
--      * add a cover page, with a session, that has quick links to all the pages i might need on a regular basis

require 'plugins'
-- all settings {{{1

-- gui settings {{{2
vim.cmd [[
if exists("g:neovide")
    let g:neovide_scroll_animation_length = 0.1
    "set guifont=Sauce\ Code\ Pro\ Mono:h15
endif
]]

-- keymaps {{{2

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("t", "<esc>", "<c-\\><c-n>", opts)
keymap("n", "<c-j>", "<cmd>set paste<cr>m`o<esc>``<cmd>set nopaste<cr>", opts)
keymap("n", "<c-k>", "<cmd>set paste<cr>m`O<esc>``<cmd>set nopaste<cr>", opts)
keymap("i", "<a-backspace>", "<c-w>", opts)
keymap("c", "<a-backspace>", "<c-w>", opts)
keymap("v", "<tab>", ">", opts)
keymap("v", "<s-tab>", "<", opts)

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

-- mapping to ensure <cr> is consistent in the popup menu
local keys = {
    ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

_G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
        -- If popup is visible, confirm selected item or add new line otherwise
        local item_selected = vim.fn.complete_info()['selected'] ~= -1
        return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
    else
        -- If popup is not visible, use plain `<CR>`. You might want to customize
        -- according to other plugins. For example, to use 'mini.pairs', replace
        -- next line with `return require('mini.pairs').cr()`
        return keys['cr']
    end
end

vim.api.nvim_set_keymap('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })

-- mappings specifically for luasnip
vim.cmd[[" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
]]
-- whichkey {{{2
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
            d = { "<cmd>lua MiniBufremove.delete()<cr>", "del buffer" },
            q = { "<cmd>lua MiniBufremove.delete(0, true)<cr>", "really del buffer!" },
            n = { "<cmd>bn<cr>", "next buffer" },
            p = { "<cmd>bp<cr>", "prev buffer" },
        },
        c = {
            name = "code",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "code actions" },
            f = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "format" },
            r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "rename" },
            t = { "<cmd>lua MiniTrailspace.trim()<cr>", "rename" },
        },
        D = { "go to type def" },
        e = { "open float" },
        f = {
            name = "file",
            f = { "<cmd>Telescope find_files<cr>", "find files" },
            n = { "<cmd>enew<cr>", "new file" },
            r = { "<cmd>Telescope oldfiles<cr>", "recent files" },
            t = { "<cmd>NvimTreeToggle<cr>", "nvim-tree" },
            w = { "<cmd>w<cr>", "save" },
            wq = { "<cmd>wq<cr>", "save-and-quit" },
        },
        g = {
            name = "go to",
            r = { "<cmd>lua vim.lsp.buf.references()<cr>", "references" }
        },
        m = { "<cmd>marks<cr>", "show marks" },
        n = {
            name = "notes",
            f = { "<cmd>lua require('telekasten').find_notes()<CR>", "find notes" },
            h = { "<cmd>lua require('telekasten').follow_link()<CR>", "follow link" },
            i = { "<cmd>lua require('telekasten').insert_link()<CR>", "insert link" },
            n = { "<cmd>lua require('telekasten').new_note()<CR>", "find notes" },
            t = { "<cmd>lua require('telekasten').toggle_todo()<CR>", "toggle to do" },
            y = { "<cmd>lua require('telekasten').yank_notelink()<CR>", "yank link to note" },
        },
        p = {
            name = "packer",
            s = { "<cmd>PackerSync<cr>", "sync" },
            c =  { "<cmd>PackerClean<cr>", "clean" },
        },
        q = { "<cmd>q<cr>", "quit" },
        r = {
            name = "r",
            s = {
                name = "send",
            },
            o = {
                name = "object",
            },
        },
        s = {
            name = "search",
            g = { "<cmd>Telescope live_grep<cr>", "find in current buf" },
            l = { "<cmd>lua MiniJump2d.start({ spotter = MiniJump2d.builtin_opts.word_start.spotter, allowed_lines = { cursor_at = true, cursor_before = false, cursor_after = false }, allowed_windows = { not_current = false }, hooks = {after_jump = function() end}})<cr>", "jump to letter" },
            n = { "<cmd>noh<cr>", "no highlight" },
            t = { "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending layout_config={\"prompt_position\":\"top\"}<cr>", "find in current buf" },
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
opt.signcolumn = 'yes:1'
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
opt.completeopt = 'noselect,noinsert,menuone,preview'

-- PLUGIN CONFIG {{{1


-- general {{{2
-- autolist {{{3

local present, autolist = pcall(require, "autolist")

if present then
    autolist.setup({})
end

-- cmp {{{3

local present, cmp = pcall(require, "cmp")

if present then 
    cmp.setup({
        snippet = {
            expand = function(args)
                require'luasnip'.lsp_expand(args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        }, 
        mapping = cmp.mapping.preset.insert({
            ['<left>'] = cmp.mapping.select_prev_item(),
            ['<right>'] = cmp.mapping.select_next_item(),
            ['<cr>'] = cmp.mapping.confirm(), 
            ['<esc>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                -- c = cmp.mapping.close(),
            }),
        }),
        enabled = function ()
            -- disable completion in comments 
            local context = require("cmp.config.context")
            -- keep command mode completion enabled when cursor is in a comment
            if vim.api.nvim_get_mode().mode == 'c' then
                return true
            else
                return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
            end
        end,
        sources = cmp.config.sources({
            { name = 'luasnip' }, 
            { name = 'omni' }, 
            { name = 'buffer' },
            { name = 'path'},
            { name = 'nvim_lua'},
        })
    })
end

-- gitsigns {{{3

local present, gitsigns = pcall(require, "gitsigns")

if present then
    gitsigns.setup({ })
end

-- luasnip {{{3
-- require("luasnip.loaders.from_vscode").lazy_load()
local present, ls = pcall(require, "luasnip")

if present then
    local fmt = require("luasnip.extras.fmt").fmt
    local date_input = function(args, snip, old_state, fmt)
        local fmt = fmt or "%Y-%m-%d"
        return ls.snippet_node(nil, ls.insert_node(1, os.date(fmt)))
    end
    ls.add_snippets("telekasten", {
        ls.snippet("novel", {
            ls.text_node("It was a dark and stormy night on "),
            ls.dynamic_node(1, date_input, {}, "%A, %B %d of %Y"),
            ls.text_node(" and the clocks were striking thirteen."),
        }),
        ls.snippet("see", {
            ls.text_node("see email from "),
            ls.insert_node(1, "Lian"),
            ls.text_node(", subject \""),
            ls.insert_node(2, "subject"),
            ls.text_node("\""),
        })
    })

    --     -- ls.add_snippets("all", {
    --     -- s("see-email", {
    --     -- t("see email from "), i(1, "from"), t(", subject: "), i(2, "subject"), 
    --     -- i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    --     -- })
    --     --    s("ternary", {
    --     -- 	-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    --     -- i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
    --     -- })
    --     -- })
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
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')

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

-- mucomplete {{{3
-- vim.cmd[[
-- let g:mucomplete#enable_auto_at_startup = 1
-- let g:mucomplete#chains = {
--             \ 'default' : ['omni', 'path'],
--             \ }
-- let g:mucomplete#chains['rmd'] = {
--             \ 'default' : ['user', 'path', 'uspl'],
--             \ 'rmdrChunk' : ['omni', 'path'],
--             \ }
-- ]]

-- neo-scroll {{{3

local present, neoscroll = pcall(require, "neoscroll")

if present then
    neoscroll.setup({
        respect_scrolloff = true,
        easing_function = 'quadratic',
    })
end
-- nvim-r {{{3
vim.cmd[[
let R_auto_start = 2
let R_assign = 2
let R_user_maps_only = 1
let r_syntax_folding = 1
]]

local nvimrmappings = vim.api.nvim_create_augroup("nvim-r-mappings", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = nvimrmappings,
    pattern = "r",
    -- callback = customNvimRMappings(),
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rf", "<Plug>RStart", {desc = "start r"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rc", "<Plug>RClose", {desc = "close r"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rq", "<Plug>RStop", {desc = "stop r"})

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>l", "<Plug>RSendLine", {desc = "send line"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>d", "<Plug>RDSendLine", {desc = "send line and down"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rsa", "<Plug>RESendFile", {desc = "send file"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rsf", "<Plug>RESendFunction", {desc = "send function"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rss", "<Plug>RESendSelection", {desc = "send selection"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rso", "<Plug>RSendSelAndInsertOutput", {desc = "send sel / insert"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rp", "<Plug>REDSendParagraph", {desc = "send paragraph"})

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>os", "<cmd>call RAction(\"str\")<cr>", {desc = "object str"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>ot", "<cmd>call RAction(\"tail\")<cr>", {desc = "object tail"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>oh", "<cmd>call RAction(\"head\")<cr>", {desc = "object head"})
        vim.api.nvim_buf_set_keymap(0, "n", "<leader>og", "<cmd>call RAction(\"glimpse\")<cr>", {desc = "object glimpse"})

        vim.api.nvim_buf_set_keymap(0, "n", "<leader>rh", "<Plug>RHelp", {desc = "help"})
    end
})
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

-- telekasten {{{3
local present, telekasten = pcall(require, "telekasten")

if present then
    telekasten.setup({
        home = vim.fn.expand("~/Documents/notes"),
        take_over_my_home = true,
        tag_notation = "#tag",
    })

    keymap("n", "<leader>n", "<cmd>lua require('telekasten').panel()<CR>", opts)
    -- nnoremap <leader>z :lua require('telekasten').panel()<CR>
end

-- telescope {{{3

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


-- toggler {{{3

local present, toggler = pcall(require, "nvim-toggler")

if present then
    toggler.setup({})
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
--
-- local present, minicomp = pcall(require, "mini.completion")
--
-- if present then
--     minicomp.setup({
--         mappings = {
--             force_twostep = '<A-Space>',
--         },
--         lsp_completion = {
--             source_func = 'omnifunc',
--         }
--     })
--     local keys = {
--         ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
--         ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
--         ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
--     }
--
--     vim.api.nvim_set_keymap('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { noremap = true, expr = true })
--     vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { noremap = true, expr = true })
--
--     _G.cr_action = function()
--         if vim.fn.pumvisible() ~= 0 then
--             -- If popup is visible, confirm selected item or add new line otherwise
--             local item_selected = vim.fn.complete_info()['selected'] ~= -1
--             return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
--         else
--             -- If popup is not visible, use plain `<CR>`. You might want to customize
--             -- according to other plugins. For example, to use 'mini.pairs', replace
--             -- next line with `return require('mini.pairs').cr()`
--             return require('mini.pairs').cr()
--             --return keys['cr']
--         end
--     end
--
--   vim.api.nvim_set_keymap('i', '<CR>', 'v:lua._G.cr_action()', { noremap = true, expr = true })
-- end

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
        spotter = jump_line_start.spotter, hooks = { after_jump = jump_line_start.hooks.after_jump }
    })
end

-- misc {{{3
local present, minimisc = pcall(require, "mini.misc")

if present then
    minimisc.setup({
    })
end

-- pairs {{{3
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
        force = { read = false, write = true, delete = false },
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

-- autocommands {{{1
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
-- restore last cursor position
local restoreCursor = vim.api.nvim_create_augroup("restoreCursor", { clear = true})
vim.api.nvim_create_autocmd(
    { "BufReadPost" },
    { pattern = "*", command = [[call setpos(".", getpos("'\""))]], group = restoreCursor }
    -- This is the lua equivalent of the following vim command:
-- vim.cmd[[
-- autocmd BufReadPost *
--   \ if line("'\"") >= 1 && line("'\"") <= line("$") |
--   \   exe "normal! g`\"" |
--   \ endif
-- ]]
    )

-- restore folds
local restoreFolds = vim.api.nvim_create_augroup("restoreFolds", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWinLeave" },
    { pattern = "?*", command = "mkview", group = restoreFolds }
)

vim.api.nvim_create_autocmd(
    { "BufWinEnter" },
    { pattern = "?*", command = "silent! loadview", group = restoreFolds }
)

-- Highlight the region on yank
local highlight = vim.api.nvim_create_augroup("highlight", { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

-- from https://github.com/echasnovski/nvim/blob/master/lua/ec/settings.lua
vim.cmd([[augroup CustomSettings]])
  vim.cmd([[autocmd!]])
  -- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
  vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=o]])
  -- But insert comment leader after hitting <CR> and respect 'numbered' lists
  vim.cmd([[autocmd FileType * setlocal formatoptions+=r formatoptions+=n]])

  -- Allow nested 'default' comment leaders to be treated as comment leader
  vim.cmd([[autocmd FileType * lua pcall(require('mini.misc').use_nested_comments)]])
vim.cmd([[augroup END]])
