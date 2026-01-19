return {
  "rcarriga/nvim-notify",
  config = function()
    local opts = {
      timeout = 1500,
      stages = "fade_in_slide_out",
      render = "default",
      background_colour = "#000000",
    }

    local notify = require("notify")
    notify.setup(opts)
    vim.notify = notify
  end,
}
