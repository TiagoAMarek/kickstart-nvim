return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'christoomey/vim-tmux-navigator',
  -- Useful plugin to show you pending keybinds.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { integrations = { mini = true, hop = true } },
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {},
  },
  {
    "nguyenvukhang/nvim-toggler",
    event = { "User AstroFile", "InsertEnter" },
    keys = {
      {
        "<leader>i",
        desc = "Toggle CursorWord",
      },
    },
    opts = {},
  }
}
