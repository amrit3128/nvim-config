return
{
  "sindrets/winshift.nvim",
  event = "VeryLazy",
  vim.keymap.set("n", "<space>wg", "<cmd>WinShift<CR>", { desc = "Interectively Shift Windows" })
}
