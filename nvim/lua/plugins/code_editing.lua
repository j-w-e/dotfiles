return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { -- nice loading notifications
        -- PERF: but can slow down startup
        'j-hui/fidget.nvim',
        enabled = false,
        opts = {},
      },
      { 'folke/neodev.nvim' },
    },

    -- THIS is my original LSP config function
    -- -- [[ Configure LSP ]]
    -- local on_attach = function(_, bufnr)
    --   local nmap = function(keys, func, desc)
    --     if desc then
    --       desc = 'LSP: ' .. desc
    --     end
    --
    --     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    --   end
    --
    --   nmap('<leader>cr', vim.lsp.buf.rename, 'rename')
    --   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    --
    --   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    --   nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    --   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    --   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    --   nmap('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'code symbols in doc')
    --   -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    --   nmap('<leader>cf', vim.lsp.buf.format, "format current buffer")
    --
    --   -- See `:help K` for why this keymap
    --   nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    --   -- the following used to be <c-k>, but I changed that to allow windor navigation
    --   nmap("<leader>ck", vim.lsp.buf.signature_help, "Signature Documentation")
    --
    --   -- Lesser used LSP functionality
    --   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    --   -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    --   -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    --   -- nmap('<leader>wl', function()
    --   --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --   -- end, '[W]orkspace [L]ist Folders')
    --
    --   -- Create a command `:Format` local to the LSP buffer
    --   -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    --   --   vim.lsp.buf.format()
    --   -- end, { desc = 'Format current buffer with LSP' })
    -- end
    --
    -- -- Enable the following language servers
    -- --  If you want to override the default filetypes that your language server will attach to you can
    -- --  define the property 'filetypes' to the map in question.
    -- local servers = {
    --   -- clangd = {},
    --   -- pyright = {},
    --   -- html = { filetypes = { 'html', 'twig', 'hbs'} },
    --
    --   lua_ls = {
    --     Lua = {
    --       workspace = { checkThirdParty = false },
    --       telemetry = { enable = false },
    --     },
    --   },
    --   -- r_language_server = { flags = { debounce_text_changes = 150 }, },
    -- }
    --
    -- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    --
    -- -- Ensure the servers above are installed
    -- local mason_lspconfig = require 'mason-lspconfig'
    --
    -- mason_lspconfig.setup {
    --   ensure_installed = vim.tbl_keys(servers),
    -- }
    --
    -- mason_lspconfig.setup_handlers {
    --   function(server_name)
    --     require('lspconfig')[server_name].setup {
    --       capabilities = capabilities,
    --       on_attach = on_attach,
    --       settings = servers[server_name],
    --       filetypes = (servers[server_name] or {}).filetypes,
    --     }
    --   end
    -- }
    --

    -- this is the LSP config function from nvim-quarto
    config = function()
      local lspconfig = require 'lspconfig'
      local util = require 'lspconfig.util'

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local telescope = require 'telescope.builtin'
          local function map(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, 'LSP client not found')

          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true

          -- map("gS", telescope.lsp_document_symbols, "[g]o so [S]ymbols")
          map('gD', telescope.lsp_type_definitions, '[g]o to type [D]efinition')
          map('gd', telescope.lsp_definitions, '[g]o to [d]efinition')
          map('K', '<cmd>lua vim.lsp.buf.hover()<CR>', '[K] hover documentation')
          map('gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', '[g]o to signature [h]elp')
          map('gi', telescope.lsp_implementations, '[g]o to [i]mplementation')
          map('gr', telescope.lsp_references, '[g]o to [r]eferences')
          map('[d', vim.diagnostic.goto_prev, 'previous [d]iagnostic ')
          map(']d', vim.diagnostic.goto_next, 'next [d]iagnostic ')
          map('<leader>ll', vim.lsp.codelens.run, '[l]ens run')
          map('<leader>lR', vim.lsp.buf.rename, '[l]sp [R]ename')
          map('<leader>lf', vim.lsp.buf.format, '[l]sp [f]ormat')
          map('<leader>lq', vim.diagnostic.setqflist, '[l]sp diagnostic [q]uickfix')
        end,
      })

      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = true,
      }
      require('mason-tool-installer').setup {
        ensure_installed = {
          'black',
          'stylua',
          'shfmt',
          'isort',
        },
      }

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {})
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {})

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- also needs:
      -- $home/.config/marksman/config.toml :
      -- [core]
      -- markdown.file_extensions = ["md", "markdown", "qmd"]
      -- lspconfig.marksman.setup {
      --   capabilities = capabilities,
      --   filetypes = { 'markdown', 'quarto' },
      --   root_dir = util.root_pattern('.git', '.marksman.toml', '_quarto.yml'),
      -- }

      lspconfig.r_language_server.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          r = {
            lsp = {
              rich_documentation = false,
            },
          },
        },
      }

      -- lspconfig.cssls.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      -- }

      -- lspconfig.html.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      -- }

      -- lspconfig.emmet_language_server.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      -- }

      -- lspconfig.yamlls.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      --   settings = {
      --     yaml = {
      --       schemaStore = {
      --         enable = true,
      --         url = '',
      --       },
      --     },
      --   },
      -- }

      -- lspconfig.dotls.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      -- }

      -- lspconfig.tsserver.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      --   filetypes = { 'js', 'javascript', 'typescript', 'ojs' },
      -- }

      local function get_quarto_resource_path()
        local function strsplit(s, delimiter)
          local result = {}
          for match in (s .. delimiter):gmatch('(.-)' .. delimiter) do
            table.insert(result, match)
          end
          return result
        end

        local f = assert(io.popen('quarto --paths', 'r'))
        local s = assert(f:read '*a')
        f:close()
        return strsplit(s, '\n')[2]
      end

      local lua_library_files = vim.api.nvim_get_runtime_file('', true)
      local lua_plugin_paths = {}
      local resource_path = get_quarto_resource_path()
      if resource_path == nil then
        vim.notify_once 'quarto not found, lua library files not loaded'
      else
        table.insert(lua_library_files, resource_path .. '/lua-types')
        table.insert(lua_plugin_paths, resource_path .. '/lua-plugin/plugin.lua')
      end

      require('neodev').setup {}

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            runtime = {
              version = 'LuaJIT',
              plugin = lua_plugin_paths,
            },
            diagnostics = {
              globals = { 'vim', 'quarto', 'pandoc', 'io', 'string', 'print', 'require', 'table' },
              disable = { 'trailing-space' },
            },
            workspace = {
              library = lua_library_files,
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lspconfig.julials.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.bashls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { 'sh', 'bash' },
      }

      -- Add additional languages here.
      -- See `:h lspconfig-all` for the configuration.
      -- Like e.g. Haskell:
      -- lspconfig.hls.setup {
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   flags = lsp_flags
      -- }

      -- lspconfig.rust_analyzer.setup{
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = {
      --     ['rust-analyzer'] = {
      --       diagnostics = {
      --         enable = false;
      --       }
      --     }
      --   }
      -- }

      -- See https://github.com/neovim/neovim/issues/23291
      -- disable lsp watcher.
      -- Too lags on linux for python projects
      -- because pyright and nvim both create too many watchers otherwise
      if capabilities.workspace == nil then
        capabilities.workspace = {}
        capabilities.workspace.didChangeWatchedFiles = {}
      end
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      lspconfig.pyright.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = false,
              diagnosticMode = 'workspace',
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern('.git', 'setup.py', 'setup.cfg', 'pyproject.toml', 'requirements.txt')(fname) or util.path.dirname(fname)
        end,
      }
    end,
  },

  { 'folke/neodev.nvim' },

  { -- generate docstrings
    'danymat/neogen',
    cmd = { 'Neogen' },
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
  },
  {
    'akinsho/git-conflict.nvim',
    init = function()
      require('git-conflict').setup {
        default_mappings = false,
        disable_diagnostics = true,
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    enabled = true,
    config = function()
      local slow_format_filetypes = { 'r' }
      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          local function on_format(err)
            if err and err:match 'timeout$' then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 200, lsp_fallback = true }, on_format
        end,
        format_after_save = function(bufnr)
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { lsp_fallback = true }
        end,
        formatters_by_ft = {
          lua = { 'mystylua' },
          python = { 'isort', 'black' },
          ['_'] = { 'trim_whitespace' },
        },
        formatters = {
          mystylua = {
            command = 'stylua',
            args = { '--indent-type', 'Spaces', '--indent-width', '2', '-' },
          },
        },
      }
      -- Customize the "injected" formatter
      require('conform').formatters.injected = {
        -- Set the options field
        options = {
          -- Set to true to ignore errors
          ignore_errors = false,
          -- Map of treesitter language to file extension
          -- A temporary file name with this extension will be generated during formatting
          -- because some formatters care about the filename.
          lang_to_ext = {
            bash = 'sh',
            -- c_sharp = 'cs',
            -- elixir = 'exs',
            -- javascript = 'js',
            -- julia = 'jl',
            -- latex = 'tex',
            markdown = 'md',
            python = 'py',
            -- ruby = 'rb',
            -- rust = 'rs',
            -- teal = 'tl',
            r = 'r',
            -- typescript = 'ts',
          },
          -- Map of treesitter language to formatters to use
          -- (defaults to the value from formatters_by_ft)
          lang_to_formatters = {},
        },
      }
    end,
  },

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  -- {
  --   'jpalardy/vim-slime',
  --   init = function()
  --     vim.b['quarto_is_python_chunk'] = false
  --     Quarto_is_in_python_chunk = function()
  --       require('otter.tools.functions').is_otter_language_context 'python'
  --     end
  --
  --     vim.cmd [[
  --     let g:slime_dispatch_ipython_pause = 100
  --     function SlimeOverride_EscapeText_quarto(text)
  --     call v:lua.Quarto_is_in_python_chunk()
  --     if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
  --     return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
  --     else
  --     if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
  --     return [a:text, "\n"]
  --     else
  --     return [a:text]
  --     end
  --     end
  --     endfunction
  --     ]]
  --
  --     local function mark_terminal()
  --       vim.g.slime_last_channel = vim.b.terminal_job_id
  --       vim.print(vim.g.slime_last_channel)
  --     end
  --
  --     local function set_terminal()
  --       vim.b.slime_config = { jobid = vim.g.slime_last_channel }
  --     end
  --
  --     vim.g.slime_target = 'neovim'
  --     vim.g.slime_python_ipython = 1
  --
  --     require('which-key').register {
  --       ['<leader>cm'] = { mark_terminal, 'mark terminal' },
  --       ['<leader>cs'] = { set_terminal, 'set terminal' },
  --     }
  --   end,
  -- },

  { -- show tree of symbols in the current file
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = {
      { '<leader>lo', ':SymbolsOutline<cr>', desc = 'symbols outline' },
    },
    opts = {},
  },

  -- { -- show diagnostics list
  --   -- PERF: Slows down insert mode if open and there are many diagnostics
  --   'folke/trouble.nvim',
  --   enabled = false,
  --   config = function()
  --     local trouble = require 'trouble'
  --     trouble.setup {}
  --     local function next()
  --       trouble.next { skip_groups = true, jump = true }
  --     end
  --     local function previous()
  --       trouble.previous { skip_groups = true, jump = true }
  --     end
  --     vim.keymap.set('n', ']t', next, { desc = 'next [t]rouble item' })
  --     vim.keymap.set('n', '[t', previous, { desc = 'previous [t]rouble item' })
  --   end,
  -- },
}
