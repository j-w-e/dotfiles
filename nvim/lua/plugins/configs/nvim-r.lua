local g = vim.g

g.R_start_libs = 'tidyverse'

g.R_user_maps_only = 0 -- only set the mappings defined here
--g.R_disable_cmds = ['RSetwd', 'RDputObj'] -- disable specific mappings, if the defauts are defined

-- Do I need to enable / disable Nvim-R's omnifunc?
-- g.R_set_omnifunc = []
-- g.R_auto_omni = ["r"]

-- autocmd TermOpen * setlocal nonumber
--" Emulate Tmux ^az
--function ZoomWindow()
--let cpos = getpos(".")
--tabnew %
--redraw
--call cursor(cpos[1], cpos[2])
--normal! zz
--endfunction
--nmap gz :call ZoomWindow()<CR>

--vim.cmd[[
--" NCM2
--autocmd BufEnter * call ncm2#enable_for_buffer()    " To enable ncm2 for all buffers.
--set completeopt=noinsert,menuone,noselect           " :help Ncm2PopupOpen for more
--" information.
--]]
