local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
  require('mini.clue').ensure_buf_triggers()
  vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end,
    { buffer = bufnr, remap = false, desc = "format" })
end)

lsp.setup()

local cmp = require('cmp')
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<up>'] = cmp.mapping.select_prev_item(),
    ['<down>'] = cmp.mapping.select_next_item(),
    ['<cr>'] = cmp.mapping.confirm(),
    ['<esc>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      -- c = cmp.mapping.abort(),
      -- c = cmp.mapping.close(),
      c = function()
        if cmp.visible() then
          cmp.close()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, true, true), 'n', true)
        end
      end
    }),
  },
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    -- { name = 'omni' },
    { name = 'nvim_lua' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 4 },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline({
    ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
    ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
  }),
  -- mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline({
    ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
    ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
  }),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

