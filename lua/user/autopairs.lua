local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
  enable_check_bracket_line = true,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
