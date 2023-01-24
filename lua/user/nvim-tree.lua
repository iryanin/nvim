local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup({
  disable_netrw = true,
  view = {
    adaptive_size = true,
    side = "left",
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
        -- v分屏打开文件
        { key = "v", action = "vsplit" },
        -- h分屏打开文件
        { key = "h", action = "split" },
        -- Hide (dotfiles)
        { key = ".", action = "toggle_dotfiles" },
        { key = "r", action = "refresh" },
        { key = "n", action = "create" },
        { key = "d", action = "remove" },
        { key = "rn", action = "rename" },
        { key = "x", action = "cut" },
        { key = "y", action = "copy" },
        { key = "p", action = "paste" },
        { key = "yn", action = "copy_name" },
        { key = "yp", action = "copy_absolute_path" },
        { key = "i", action = "toggle_file_info" },
        { key = { "o" }, action = "cd" },
        { key = { "u" }, action = "dir_up" },
      },
    },
    signcolumn = "yes",
  },
})
