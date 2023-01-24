local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
  return
end

local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
  return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {
      left = "|",
      right = "|",
    },
    section_separators = {
      left = " ",
      right = "",
    },
    disabled_filetypes = {
      statusline = { "alpha" },
      winbar = { "alpha" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename', {
      'lsp_progress',
      display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
      separators = {
        component = ' ',
        progress = ' | ',
        message = { pre = '(', post = ')', commenced = 'In Progress', completed = 'Completed' },
        percentage = { pre = '', post = '%% ' },
        title = { pre = '', post = ': ' },
        lsp_client_name = { pre = '[', post = ']' },
        spinner = { pre = '', post = '' },
      },
      timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
      spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
    } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1, color = { bg = 'NONE' }, cond = navic.is_available },
      { navic.get_location, cond = navic.is_available } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {},
  extensions = { "nvim-tree", "symbols-outline", "nvim-dap-ui" },
}
