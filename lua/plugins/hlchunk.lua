return {
  "shellRaining/hlchunk.nvim",
  enabled = false,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({})
  end
}
