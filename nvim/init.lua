
-- 5. add smart-dd to n and v modes: https://www.reddit.com/r/neovim/comments/w0jzzv/smart_dd/
-- 6. add sessions in to alpha, and convert dashboard to startify layout
--      * https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/startify.lua is the startify setup file 
--      * https://github.com/Shatur/neovim-session-manager is the sessions manager
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
-- 20. make sure I've imported all the sensible settings from my various branches, such as the ability to resume editing at a the most recent point 
require "plugins"
-- all configurations for plugins
require "plugins/cmp"
require "plugins/lsp-installer"
require "plugins/lspconfig"
require "plugins/nvim-treesitter"
require "plugins/telescope"
require "plugins/lualine"
require "plugins/bufferline"
require "plugins/clever-f"
require "plugins/nvim-tree"
require "plugins/null-ls"
require "plugins/hop"
require "plugins/whichkey"
require "plugins/nvim-r"
require "plugins/alpha"
-- all settings
require "settings/keymaps"
require "settings/options"
require "settings/styles"
require "settings/autocmds"

