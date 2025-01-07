return {
  {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
    version = false,
    config = function()
      -- local statusline = require 'mini.statusline'
      -- statusline.setup {
      --   content = {
      --     active = nil,
      --     inactive = nil,
      --   },
      --   use_icons = true,
      --   set_vim_settings = true,
      -- }

      -- local starter = require 'mini.starter'
      -- starter.setup { use_icons = true }

      -- local session = require 'mini.sessions'
      -- session.setup()

      local move = require 'mini.move'
      move.setup({
        {
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = '<M-h>',
            right = '<M-l>',
            down = '<M-j>',
            up = '<M-k>',

            -- Move current line in Normal mode
            line_left = '<M-h>',
            line_right = '<M-l>',
            line_down = '<M-j>',
            line_up = '<M-k>',
          },

          -- Options which control moving behavior
          options = {
            -- Automatically reindent selection during linewise vertical move
            reindent_linewise = true,
          },
        }
      })

      local files = require 'mini.files'
      files.setup { use_icons = true }
      vim.keymap.set("n", "<space>e", function() MiniFiles.open() end, { desc = "Mini Files" })

      local ai = require 'mini.ai'
      ai.setup()

      -- local pick = require 'mini.pick'
      -- pick.setup()
    end,
  }
}
