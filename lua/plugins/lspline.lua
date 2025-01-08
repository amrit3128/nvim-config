return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require("lsp_lines").setup()
  end,
}
