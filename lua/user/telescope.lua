local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  mappings = {
    i = {
      ["<C-n>"] = "move_selection_next",
      ["<C-p>"] = "move_selection_previous",
      ["<Down>"] = "cycle_history_next",
      ["<Up>"] = "cycle_history_prev",
      ["<C-u>"] = "preview_scrolling_up",
      ["<C-d>"] = "preview_scrolling_down",
    },
  },
  pickers = {
  },
  extensions = {
  }
})

telescope.load_extension('projects')
