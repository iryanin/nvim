local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	return
end

vim.g.nvim_tree_respect_buf_cwd = 1
project.setup({
  detection_methods = { "pattern" },
  patterns = {
    "README.md",
    "Cargo.toml",
    "package.json",
    ".sln",
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
  },
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

telescope.load_extension('projects')