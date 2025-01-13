return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    ---@diagnostic disable-next-line: missing-parameter
    require("lualine").setup()
  end,
}
