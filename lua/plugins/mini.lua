return {
  {
    'echasnovski/mini.nvim',
    event = "VeryLazy",
    version = false,
    config = function()
      -- require("mini.statusline").setup {
      --   content = {
      --     active = nil,
      --     inactive = nil,
      --   },
      --   use_icons = true,
      --   set_vim_settings = true,
      -- }

      -- require("mini.starter").setup { use_icons = true }
      -- require("mini.sessions").setup()

      require("mini.move").setup({
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

      require("mini.pairs").setup()

      require("mini.files").setup { use_icons = true }
      vim.keymap.set("n", "<space>e", function() MiniFiles.open() end, { desc = "Mini Files" })

      require("mini.ai").setup()
      -- require("mini.pick").setup()
    end,
  }
}
