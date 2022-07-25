
-- 4. check vim-wiki for a potential note-taking solution
-- 5. add smart-dd to n and v modes: https://www.reddit.com/r/neovim/comments/w0jzzv/smart_dd/
-- 6. add nvim-r
-- 7. work out how to implement "which_key_ignore" as a key description for mappings
-- 8. check filetype on, filetype plugin on, and filetype indent on, or their lsp equivalents
-- 9. ensure i'm displaying listchars. "set listchars=tab:▸\ ,lead:·,trail:·"
-- 10. do I need wildmenu options for path+=**, wildignore=**/node_modules/** is what i had in v3, _jwe_.lua
-- 12. fix the autopairs plugin? https://github.com/windwp/nvim-autopairs
-- 13. configure treesitter to work with r, lua and c. (see what i had in config v3)
-- 14. configure lsp. again see v3. including setting omnifunc to a sensible keymappings. and enable document formatting if I can?
-- 15. think about whether c-n, c-p, c-y and c-e are good enough for wildmenu, or whether i need to implement https://vi.stackexchange.com/questions/22627/switching-arrow-key-mappings-for-wildmenu-tab-completion 
-- 18. Bindings ideas:
--      * move window? 
--      * space space and arrows to shift between windows?
--      * nvim-r bindings which conflict with ripgrep for example
-- 19. get R completion working. 
--      * matmarqs alsmost works. see https://github.com/matmarqs/dotfiles/blob/10c1820158d7736081d978b459e030e4ca6a9330/house/.config/nvim/init.lua. What does not work is the menu opening automatically
require "plugins"
-- all configurations for plugins
require "plugins/configs/cmp"
require "plugins/configs/lsp-installer"
require "plugins/configs/lspconfig"
require "plugins/configs/nvim-treesitter"
require "plugins/configs/telescope"
require "plugins/configs/lualine"
require "plugins/configs/bufferline"
require "plugins/configs/clever-f"
require "plugins/configs/nvim-tree"
require "plugins/configs/null-ls"
require "plugins/configs/hop"
require "plugins/configs/whichkey"
require "plugins/configs/nvim-r"
-- all settings
require "settings/keymaps"
require "settings/options"
require "settings/styles"
require "settings/autocmds"

-- setting for ncm_r to work
--vim.g.python3_host_prog='/usr/local/bin/python3'
--vim.g.python_host_prog='/usr/bin/python'
