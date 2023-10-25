-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("install-lazy")
require("options")
require("keymaps")

require('satellite').setup {
  current_only = false,
  winblend = 50,
  zindex = 40,
  excluded_filetypes = {},
  width = 2,
  handlers = {
    cursor = {
      enable = true,
      -- Supports any number of symbols
      symbols = { '⎺', '⎻', '⎼', '⎽' }
    },
    search = {
      enable = true,
    },
    diagnostic = {
      enable = true,
      signs = { '-', '=', '≡' },
      min_severity = vim.diagnostic.severity.HINT,
    },
    gitsigns = {
      enable = true,
      signs = { -- can only be a single character (multibyte is okay)
        add = "│",
        change = "│",
        delete = "-",
      },
    },
    marks = {
      enable = true,
      show_builtins = false, -- shows the builtin marks like [ ] < >
      key = 'm'
    },
    quickfix = {
      signs = { '-', '=', '≡' },
    }
  },
}

require("oil").setup({
  default_file_explorer = true,
  columns = {
    "icon",
    "size",
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<M-s>"] = "actions.select_vsplit",
    ["<M-h>"] = "actions.select_split",
    ["<M-t>"] = "actions.select_tab",
    ["<M-p>"] = "actions.preview",
    ["<M-c>"] = "actions.close",
    ["<M-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  },
  use_default_keymaps = false,
})

-- document existing key chains
require('which-key').register({
  ['<leader>c'] = { name = '[M]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]pectre', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
})


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
