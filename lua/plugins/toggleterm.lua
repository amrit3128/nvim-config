return
{
  'akinsho/toggleterm.nvim',
  event = "VeryLazy",
  -- enabled = false,
  version = "*",
  -- config = true,
  config = function()
    require("toggleterm").setup {
      direction = 'float',
    }
  end,

  -- vim.keymap.set({ "n", "i", "v", "t" }, "<C-/>", "<cmd>ToggleTerm direction=float<CR>"),
  vim.keymap.set({ "n", "i", "v", "t" }, "<C-/>", "<cmd>ToggleTerm direction=float<CR>"),
  vim.keymap.set({ "n", "i", "v", "t" }, "<M-z>", "<cmd>ToggleTerm size=20 direction=horizontal<CR>"),
}
