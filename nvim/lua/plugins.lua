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
    use 'nvim-treesitter/nvim-treesitter'  -- language parsing completion engine
    --use 'williamboman/nvim-lsp-installer'  -- UI for fetching/downloading LSPs
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig'            -- language server protocol implementation
    use 'williamboman/mason-lspconfig.nvim'

    use 'hrsh7th/nvim-cmp'                 -- THE vim completion engine
    use 'hrsh7th/cmp-omni'                 
    --use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'jose-elias-alvarez/null-ls.nvim' -- see https://www.youtube.com/watch?v=b7OguLuaYvE
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'
    use 'hkupty/iron.nvim'
    use 'j-hui/fidget.nvim'

    use 'nvim-telescope/telescope.nvim'    -- finder, requires fzf and ripgrep
    use 'kyazdani42/nvim-tree.lua'
    use 'jalvesaq/Nvim-R'
    use 'kyazdani42/nvim-web-devicons'
    use 'lewis6991/gitsigns.nvim'
    use 'echasnovski/mini.nvim'
    use 'karb94/neoscroll.nvim'
    use 'renerocksai/telekasten.nvim'
    -- use {
    --     'phaazon/mind.nvim',
    --     branch = 'v2',
    --     requires = { 'nvim-lua/plenary.nvim' },
    --     config = function()
    --         require'mind'.setup()
    --     end
    -- }
    use 'gaoDean/autolist.nvim'
    use 'sam4llis/nvim-lua-gf'
    use 'mtth/scratch.vim'
    use 'nguyenvukhang/nvim-toggler'
   --use 'lifepillar/vim-mucomplete'
    --use 'JoseConseco/telescope_sessions_picker.nvim'
    --use 'phaazon/mind.nvim'
    use { 'j-w-e/telescope_sessions_picker.nvim', branch = 'devel' }
    use 'folke/which-key.nvim'

    if Packer_Bootstrap then
        require('packer').sync()
    end
end)

