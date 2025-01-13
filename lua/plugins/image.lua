return {
  "3rd/image.nvim",
  event = "VeryLazy",
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {},
  config = function()
    require("image").setup({
      ---@diagnostic disable-next-line: missing-fields
      processor = "magick_cli",
    })
  end,
}
