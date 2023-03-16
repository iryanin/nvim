local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter.setup({
  ensure_installed = "all",
  -- ignore_install = { "phpdoc" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
  },
  -- p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {
    -- 	"#95ca60",
    -- 	"#ee6985",
    -- 	"#D6A760",
    -- 	"#7794f4",
    -- 	"#b38bf5",
    -- 	"#7cc7fe",
    -- }, -- table of hex strings
  },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- no fold at startup
vim.opt.foldlevel = 99
