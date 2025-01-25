return {
    "aaronik/treewalker.nvim",
    event = "VeryLazy",

    -- The following options are the defaults.
    -- Treewalker aims for sane defaults, so these are each individually optional,
    -- and setup() does not need to be called, so the whole opts block is optional as well.
    opts = {
      -- Whether to briefly highlight the node after jumping to it
      highlight = true,

      -- How long should above highlight last (in ms)
      highlight_duration = 250,

      -- The color of the above highlight. Must be a valid vim highlight group.
      -- (see :h highlight-group for options)
      highlight_group = "CursorLine",
    },

    vim.keymap.set("n", "<space>tj", "<cmd>Treewalker Down<CR>", { desc = "Treewalker Down" }),
    vim.keymap.set("n", "<space>tk", "<cmd>Treewalker Up<CR>", { desc = "Treewalker Up" }),
    vim.keymap.set("n", "<space>tl", "<cmd>Treewalker Right<CR>", { desc = "Treewalker Right" }),
    vim.keymap.set("n", "<space>th", "<cmd>Treewalker Left<CR>", { desc = "Treewalker Left" }),

    vim.keymap.set("n", "<space>tsj", "<cmd>Treewalker SwapDown<CR>", { desc = "Treewalker Swap Down" }),
    vim.keymap.set("n", "<space>tsk", "<cmd>Treewalker SwapUp<CR>", { desc = "Treewalker Swap Up" }),
    vim.keymap.set("n", "<space>tsl", "<cmd>Treewalker SwapRight<CR>", { desc = "Treewalker Swap Right" }),
    vim.keymap.set("n", "<space>tsh", "<cmd>Treewalker SwapLeft<CR>", { desc = "Treewalker Swap Left" }),
  }
