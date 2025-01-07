return {
  'nvim-telescope/telescope.nvim',
  event = "VeryLazy",
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' } },

  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
        },
        diagnostics = {
          theme = "dropdown"
        },
        buffers = {
          theme = "dropdown"
        },
        colorscheme = {
          theme = "dropdown"
        },
        builtin = {
          theme = "dropdown"
        }
      },
      extensions = {
        fzf = {}
      }
    }

    require('telescope').load_extension('fzf')

    vim.keymap.set("n", "<space><space>", require('telescope.builtin').fd, { desc = "Find Files" })
    -- vim.keymap.set("n", "<space>ff", require('telescope.builtin').fd, {desc = "Delete Buffer"})
    vim.keymap.set("n", "<space>fb", require('telescope.builtin').current_buffer_fuzzy_find,
      { desc = "Find in Current Buffer" })
    -- vim.keymap.set("n", "<space>ht", require('telescope.builtin').colorscheme, {desc = "Delete Buffer"})
    vim.keymap.set("n", "<space>fr", require('telescope.builtin').oldfiles, { desc = "Find Recent Files" })
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, { desc = "Help Tags" })
    vim.keymap.set("n", "<space>/", require('telescope.builtin').live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<space>ht", require('telescope.builtin').builtin, { desc = "Telescope All" })
    vim.keymap.set("n", "<space>,", require('telescope.builtin').buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<space>.", require('telescope.builtin').fd, { desc = "Find Files" })
    vim.keymap.set("n", "<space>cd", require('telescope.builtin').diagnostics, { desc = "Telescope Diagnostics" })

    vim.keymap.set("n", "<space>fp", function()
        require('telescope.builtin').find_files {
          ---@diagnostic disable-next-line: param-type-mismatch
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end,
      { desc = "Find in CWD" }
    )

    vim.keymap.set("n", "<space>fc", function()
        require('telescope.builtin').fd {
          cwd = vim.fn.stdpath("config")
        }
      end,
      { desc = "Find Config" }
    )

    require "telescope.multigrep".setup()
  end,
}
