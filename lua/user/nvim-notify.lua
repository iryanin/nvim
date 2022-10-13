local nvim_notify = require("notify")
nvim_notify.setup {
        background_colour = "Normal",
        fps = 120,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = ""
        },
        level = 1,
        minimum_width = 50,
        render = "default",
        stages = "fade_in_slide_out",
        timeout = 1500,
        top_down = true
      }

vim.notify = nvim_notify
vim.notify = function(msg, ...)
          if msg:match('warning: multiple different client offset_encodings') then
            return
          end
          nvim_notify(msg, ...)
        end
