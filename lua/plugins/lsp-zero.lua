return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(
        function(client, bufnr)
          lsp_zero.default_keymaps({ buffer = bufnr })

          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local normalModeMap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          normalModeMap('<leader>r', vim.lsp.buf.rename, '[R]ename')
          normalModeMap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          normalModeMap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          normalModeMap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          normalModeMap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          normalModeMap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
          normalModeMap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          normalModeMap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- See `:help K` for why this keymap
          normalModeMap('K', vim.lsp.buf.hover, 'Hover Documentation')
          normalModeMap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Lesser used LSP functionality
          normalModeMap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end
      )

      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['eslint'] = { 'javascript', 'typescript' },
          ['jsonls'] = { 'json' },
          ['lua_ls'] = { 'lua' },
          ['tsserver'] = { 'javascript', 'typescript' },
        }
      })

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'tsserver', 'eslint', 'jsonls', 'lua_ls' },
        handlers = {
          lsp_zero.default_setup,
        }
      })

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      -- autocomplete configs
      cmp.setup({
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
      })
    end
  },
}
