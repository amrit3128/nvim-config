return {
  "roobert/tabtree.nvim",
  event = "VeryLazy",
  -- enabled = true,
  config = function()
    require("tabtree").setup()
  end,
}
