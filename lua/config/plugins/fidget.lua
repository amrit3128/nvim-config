return {
  {
    "j-hui/fidget.nvim",
    lazy = false,
    enabled = true,
    config = function()
    end,
    opts = {
      notification = {
        history_size = 128,         -- Number of removed messages to retain in history
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
      },
    },
  },
}
