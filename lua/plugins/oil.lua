return {
  "stevearc/oil.nvim",
  opts = {},
  enabled = true,
  cmd = "Oil",
  keys = {
    { "<leader>o", function() require("oil").open() end, desc = "Open folder in Oil" },
  },
}
