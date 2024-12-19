return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
      local starter = require 'mini.starter'
      starter.setup { use_icons = true }
      local files = require 'mini.files'
      files.setup { use_icons = true }
      vim.keymap.set("n", "<space>e", function() MiniFiles.open() end)
    end,
  }
}
