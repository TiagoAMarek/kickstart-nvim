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


      -- lsp_zero.format_on_save({
      --   format_opts = {
      --     async = false,
      --     timeout_ms = 10000,
      --   },
      --   servers = {
      --     ['eslint-lsp'] = { 'javascript', 'typescript' },
      --     ['jsonls'] = { 'json' },
      --     ['lua_ls'] = { 'lua' },
      --     ['html'] = { 'html' },
      --     ['tsserver'] = { 'javascript', 'typescript' },
      --   }
      -- })
      --
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
        end
      )

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set('n', '<leader>x', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        end
      })
    end
  },
}
