-- lazy.nvim
return {
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    config = function()
      require("hardtime").setup()
    end
  },
}
