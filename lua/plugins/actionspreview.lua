return {
  "aznhe21/actions-preview.nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    local hl = require("actions-preview.highlight")
    require("actions-preview").setup {
      highlight_command = {
        -- Highlight diff using delta: https://github.com/dandavison/delta
        -- The argument is optional, in which case "delta" is assumed to be
        -- specified.
        hl.delta("usr/bin/delta"),
        -- You may need to specify "--no-gitconfig" since it is dependent on
        -- the gitconfig of the project by default.
        -- hl.delta("delta --no-gitconfig --side-by-side"),

        -- Highlight diff using diff-so-fancy: https://github.com/so-fancy/diff-so-fancy
        -- The arguments are optional, in which case ("diff-so-fancy", "less -R")
        -- is assumed to be specified. The existence of less is optional.
        hl.diff_so_fancy("/usr/bin/delta"),

        -- Highlight diff using diff-highlight included in git-contrib.
        -- The arguments are optional; the first argument is assumed to be
        -- "diff-highlight" and the second argument is assumed to be
        -- `{ colordiff = "colordiff", pager = "less -R" }`. The existence of
        -- colordiff and less is optional.
        hl.diff_highlight(
          "/usr/bin/delta",
          { colordiff = "path/to/colordiff" }
        ),

        -- And, you can use any command to highlight diff.
        -- Define the pipeline by `hl.commands`.
        hl.commands({
          { cmd = "/usr/bin/delta" },
          -- `optional` can be used to define that the command is optional.
          { cmd = "/usr/bin/delta", optional = true },
        }),
        -- If you use optional `less -R` (or similar command), you can also use `hl.with_pager`.
        hl.with_pager("/usr/bin/delta"),
        -- hl.with_pager("command-to-diff-highlight", "custom-pager"),
      },
    }
  end,
}
