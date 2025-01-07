return {
  "stevearc/oil.nvim",
  enabled = false,
  dependencies = {
    { 'echasnovski/mini.nvim',       version = '*' },
    { 'nvim-tree/nvim-web-devicons', version = '*' },
  },
  opts = {
  },
  config = function()
    require("oil").setup()
    vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
  end
}
