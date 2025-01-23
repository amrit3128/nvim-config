return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
      },
    },

    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "ivy"
          },
          diagnostics = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
          },
          colorscheme = {
            theme = "dropdown",
          },
          builtin = {
            theme = "dropdown",
          },
        },
        extensions = {
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")

      vim.keymap.set("n", "<space><space>", require("telescope.builtin").fd, { desc = "Find Files" })
      vim.keymap.set(
        "n",
        "<space>fb",
        require("telescope.builtin").current_buffer_fuzzy_find,
        { desc = "Find in Current Buffer" }
      )
      vim.keymap.set("n", "<space>fr", require("telescope.builtin").oldfiles, { desc = "Find Recent Files" })
      -- vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags, { desc = "Help Tags" })
      vim.keymap.set("n", "<space>/", require("telescope.builtin").live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<space>ht", require("telescope.builtin").builtin, { desc = "Telescope All" })
      vim.keymap.set("n", "<space>,", require("telescope.builtin").buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<space>.", require("telescope.builtin").fd, { desc = "Find Files" })
      vim.keymap.set("n", "<space>cd", require("telescope.builtin").diagnostics, { desc = "Telescope Diagnostics" })
      vim.api.nvim_set_keymap(
        "n",
        "<Leader>fh",
        ':lua require"telescope.builtin".find_files({ hidden = true })<CR>',
        { noremap = true, silent = true, desc = "Find Files in hidden directories" }
      )

      vim.keymap.set("n", "<space>fp", function()
        require("telescope.builtin").find_files({
          ---@diagnostic disable-next-line: param-type-mismatch
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
        })
      end, { desc = "Find in CWD" })

      vim.keymap.set("n", "<space>fc", function()
        require("telescope.builtin").fd({
          cwd = vim.fn.stdpath("config"),
        })
      end, { desc = "Find Config" })

      require("telescope.multigrep").setup()
    end,
  },
  {
    "jvgrootveld/telescope-zoxide",
    event = "VeryLazy",
    config = function()
      -- Useful for easily creating commands
      local z_utils = require("telescope._extensions.zoxide.utils")

      require("telescope").setup({
        -- (other Telescope configuration...)
        extensions = {
          zoxide = {
            -- prompt_title = "[ Walking on the shoulders of TJ ]",
            prompt_title = "",
            mappings = {
              default = {
                after_action = function(selection)
                  print("Update to (" .. selection.z_score .. ") " .. selection.path)
                end,
              },
              ["<C-s>"] = {
                before_action = function(selection)
                  print("before C-s")
                end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end,
              },
              -- Opens the selected entry in a new split
              ["<C-q>"] = { action = z_utils.create_basic_command("split") },
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>zo", require("telescope").extensions.zoxide.list, { desc = "Telescope Zozide" })
    end,
  },
}
