return
{
  'Chaitanyabsprip/fastaction.nvim',
  ---@type FastActionConfig
  opts = {},
  vim.keymap.set(
    { 'n', 'x' },
    '<leader>ca',
    '<cmd>lua require("fastaction").code_action()<CR>',
    { buffer = bufnr }
  )
}
