local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local list_keys = require("user.keymaps").nvimTreeList

nvim_tree.setup{
  disable_netrw = true,
view = {
    -- 宽度
    width = 34,
    -- 也可以 'right'
    side = "left",
    -- 隐藏根目录
    hide_root_folder = false,
    -- 自定义列表中快捷键
    mappings = {
      -- 只用内置快捷键
      custom_only = true,
      list = list_keys,
    },
    -- 显示图标
    signcolumn = "yes",
  },
}