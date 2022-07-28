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
require "plugins/mini"
require "plugins/autopairs"

-- all settings
require "settings/keymaps"
require "settings/options"
require "settings/styles"
require "settings/autocmds"

