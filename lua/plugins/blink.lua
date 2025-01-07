return {
  {
    'saghen/blink.cmp',

    event = "VeryLazy",
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    version = 'v0.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', },
        cmdline = {},
      },

      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },
}
