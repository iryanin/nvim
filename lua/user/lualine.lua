local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup({
  options = {
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
    theme = "onedark",
    -- 分割线
    component_separators = {
      left = "|",
      right = "|",
    },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = {
      left = " ",
      right = "",
    },
    globalstatus = true,
  },
  extensions = { "nvim-tree" },
})
