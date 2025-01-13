return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- enabled = false,
  event = "FileType markdown",
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },   -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require("render-markdown").setup()
  end,
}
