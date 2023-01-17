-- PACKER and plugin commands {{{1
-- packer set-up {{{2
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
   autocmd BufWritePost plugins.lua source <afile> | PackerSync
   autocmd BufEnter .lua set fdm=marker
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
    use 'nvim-telescope/telescope.nvim'    -- finder, requires fzf and ripgrep
    use 'nvim-treesitter/nvim-treesitter'  -- language parsing completion engine
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/playground'
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig'            -- language server protocol implementation
    use 'williamboman/mason-lspconfig.nvim'
    use 'lewis6991/gitsigns.nvim'
    use 'echasnovski/mini.nvim'

    use 'hrsh7th/nvim-cmp'                 -- THE vim completion engine
    use 'hrsh7th/cmp-omni'
    --use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'jose-elias-alvarez/null-ls.nvim' -- see https://www.youtube.com/watch?v=b7OguLuaYvE
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    use 'hkupty/iron.nvim'
    -- use 'j-w-e/neo-minimap'
    use 'ziontee113/neo-minimap'
    use 'j-hui/fidget.nvim'

    use 'kyazdani42/nvim-tree.lua'
    use 'jalvesaq/Nvim-R'
    use 'kyazdani42/nvim-web-devicons'
    use 'karb94/neoscroll.nvim'
    use 'renerocksai/telekasten.nvim'
    -- use { 'j-w-e/telekasten.nvim', branch = 'devel' }
    use 'tpope/vim-fugitive'
    use 'samjwill/nvim-unception'
    use 'romainl/vim-cool'

    -- use 'abecodes/tabout.nvim'

    use { 'rafcamlet/nvim-luapad', requires = "antoinemadec/FixCursorHold.nvim" }
    use 'jez/vim-better-sml'
    -- use 'marko-cerovac/material.nvim'

    -- use { 'melkster/modicator.nvim',
    --     after = 'material.nvim',
    --     config = function()
    --         require('modicator').setup()
    --     end
    -- }

    use {
        'tamton-aquib/duck.nvim',
        config = function()
            vim.keymap.set('n', '<leader>kd', function() require("duck").hatch("🐈") end, { desc = "release cat"})
            vim.keymap.set('n', '<leader>kk', function() require("duck").cook() end, { noremap = true, desc = "kill cat" })
        end
    }

    use ( {
        'princejoogie/dir-telescope.nvim',
        requires = "nvim-telescope/telescope.nvim",
        config = function()
            require("dir-telescope").setup()
            vim.keymap.set('n', '<leader>sd', "<cmd>FileInDirectory<cr>", { noremap = true, silent = true, desc = "Find in dir" })
        end,
    } )

    -- use { "Jxstxs/conceal.nvim", requires = "nvim-treesitter/nvim-treesitter" }
    -- use({
    --     "folke/noice.nvim",
    --     event = "VimEnter",
    --     config = function()
    --         require("noice").setup()
    --     end,
    --     requires = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --         "hrsh7th/nvim-cmp",
    --     }
    -- })

    use 'gaoDean/autolist.nvim'
    use 'sam4llis/nvim-lua-gf' -- adds the ability to go to a lua file with gf
    use 'mtth/scratch.vim'
    use 'nguyenvukhang/nvim-toggler'
   --use 'lifepillar/vim-mucomplete'
    --use 'phaazon/mind.nvim'
    use 'JoseConseco/telescope_sessions_picker.nvim'
    -- use { 'j-w-e/telescope_sessions_picker.nvim', branch = 'devel' }
    use 'folke/which-key.nvim'

    if Packer_Bootstrap then
        require('packer').sync()
    end
end)

