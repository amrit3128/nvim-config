return {
  "saecki/live-rename.nvim",
  event = "VeryLazy",
  config = function()
    -- default config
    require("live-rename").setup({
      -- Send a `textDocument/prepareRename` request to the server to
      -- determine the word to be renamed, can be slow on some servers.
      -- Otherwise fallback to using `<cword>`.
      prepare_rename = true,
      --- The timeout for the `textDocument/prepareRename` request and final
      --- `textDocument/rename` request when submitting.
      request_timeout = 1500,
      -- Make an initial `textDocument/rename` request to gather other
      -- occurences which are edited and use these ranges to preview.
      -- If disabled only the word under the cursor will have a preview.
      show_other_ocurrences = true,
      -- Try to infer patterns from the initial `textDocument/rename` request
      -- and use these to show hopefully better edit previews.
      use_patterns = true,
      keys = {
        submit = {
          { "n", "<cr>" },
          { "v", "<cr>" },
          { "i", "<cr>" },
        },
        cancel = {
          { "n", "<esc>" },
          { "n", "q" },
        },
      },
      hl = {
        current = "CurSearch",
        others = "Search",
      },
    })
  end
}
