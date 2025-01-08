return {
  "otavioschwanck/arrow.nvim",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  opts = {
    show_icons = true,
    leader_key = ';', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
  }
}
