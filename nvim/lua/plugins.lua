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
   augroup end
]]

-- Use a protected call
local present, packer = pcall(require, "packer")

if not present then
    return
end

packer.startup(function(use)
    use 'wbthomason/packer.nvim'           -- packer manages itself 
    use 'nvim-lua/plenary.nvim'            -- avoids callbacks, used by other plugins
    use 'nvim-lua/popup.nvim'              -- popup for other plugins
    use 'nvim-treesitter/nvim-treesitter'  -- language parsing completion engine
    use 'williamboman/nvim-lsp-installer'  -- UI for fetching/downloading LSPs
    use 'neovim/nvim-lspconfig'            -- language server protocol implementation
    use 'hrsh7th/nvim-cmp'                 -- THE vim completion engine
    use 'L3MON4D3/LuaSnip'                 -- more snippets
    use 'saadparwaiz1/cmp_luasnip'         -- even more snippets
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'nvim-telescope/telescope.nvim'    -- finder, requires fzf and ripgrep
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    use 'kyazdani42/nvim-tree.lua'
    use 'jose-elias-alvarez/null-ls.nvim' -- see https://www.youtube.com/watch?v=b7OguLuaYvE
    use 'windwp/nvim-autopairs'
    use 'phaazon/hop.nvim'
    use 'famiu/bufdelete.nvim'
    use 'rhysd/clever-f.vim'
    use 'jalvesaq/Nvim-R'
    --use 'gaalcaras/ncm-R'
    --use 'ncm2/ncm2'
    --use 'roxma/nvim-yarp'
    use 'goolord/alpha-nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'echasnovski/mini.nvim'
    use 'JoseConseco/telescope_sessions_picker.nvim'
    use 'folke/which-key.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_Bootstrap then
        require('packer').sync()
    end
end)

