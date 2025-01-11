return
{
  'hat0uma/csvview.nvim',
  event = "VeryLazy",
  config = function()
    require('csvview').setup()
  end
}
