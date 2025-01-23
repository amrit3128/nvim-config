return {
  {
    -- Better quickfix window
    "kevinhwang91/nvim-bqf",
    event = "FileType qf",
  },

  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
