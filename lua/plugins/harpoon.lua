return {
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "Harpoon" },
    keys = {
      { "<M-a>", function() require("harpoon.mark").add_file() end,        desc = "Add file" },
      { "<M-q>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle quick menu" },
      { "<M-,>", function() require("harpoon.ui").nav_prev() end,          desc = "Goto previous mark" },
      { "<M-.>", function() require("harpoon.ui").nav_next() end,          desc = "Goto next mark" },
      { "<M-m>", "<cmd>Telescope harpoon marks<CR>",                       desc = "Show marks in Telescope" },
    },
  },
}
