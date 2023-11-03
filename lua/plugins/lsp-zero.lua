return {
  {
    'SmiteshP/nvim-navic',
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
    keys = {
      {
        "<leader>n",
        function()
          require('nvim-navbuddy').open()
        end,
        desc = "Open NavBuddy",
      }
    }
  },
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
    init = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(
        function(client, bufnr)
          -- add breadcrumbs
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
          end
          -- breadcrumbs navigation
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navbuddy").attach(client, bufnr)
          end

          lsp_zero.default_keymaps({ buffer = bufnr })

          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local normalModeMap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          normalModeMap('<leader>r', vim.lsp.buf.rename, 'Rename')
          normalModeMap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

          normalModeMap('gd', vim.lsp.buf.definition, 'Goto Definition')
          normalModeMap('gr', require('telescope.builtin').lsp_references, 'Goto References')
          normalModeMap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          normalModeMap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
          normalModeMap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          normalModeMap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

          -- See `:help K` for why this keymap
          normalModeMap('K', vim.lsp.buf.hover, 'Hover Documentation')
          normalModeMap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Lesser used LSP functionality
          normalModeMap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
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
          ['html'] = { 'html' },
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
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
      })
    end
  },
}
