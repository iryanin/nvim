local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")
-- telescope.load_extension("ui-select")
telescope.load_extension("dap")

telescope.setup({
  defaults = {
    mappings = require("user.keymaps").telescopeList,
  },
  -- extensions = {
  -- 	["ui-select"] = {
  -- 		require("telescope.themes").get_dropdown{},
  -- 	},
  -- },
})
