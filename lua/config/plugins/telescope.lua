return {
  'nvim-telescope/telescope.nvim',
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

    vim.keymap.set("n", "<space><space>", require('telescope.builtin').fd)
    -- vim.keymap.set("n", "<space>ff", require('telescope.builtin').fd)
    vim.keymap.set("n", "<space>fb", require('telescope.builtin').current_buffer_fuzzy_find)
    vim.keymap.set("n", "<space>ht", require('telescope.builtin').colorscheme)
    vim.keymap.set("n", "<space>fr", require('telescope.builtin').oldfiles)
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<space>/", require('telescope.builtin').live_grep)
    vim.keymap.set("n", "<space>t", require('telescope.builtin').builtin)
    vim.keymap.set("n", "<space>,", require('telescope.builtin').buffers)
    vim.keymap.set("n", "<space>.", require('telescope.builtin').fd)
    vim.keymap.set("n", "<space>cd", require('telescope.builtin').diagnostics)

    vim.keymap.set("n", "<space>fp", function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      }
    end
    )

    vim.keymap.set("n", "<space>fc", function()
      require('telescope.builtin').fd {
        cwd = vim.fn.stdpath("config")
      }
    end
    )

    require "config.telescope.multigrep".setup()
  end,
}
