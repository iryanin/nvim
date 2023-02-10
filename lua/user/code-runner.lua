local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
  return
end

code_runner.setup({
  -- choose default mode (valid term, tab, float, toggle, buf)
  mode = 'term',
  -- Focus on runner window(only works on toggle, term and tab mode)
  focus = true,
  -- startinsert (see ':h inserting-ex')
  startinsert = false,
  term = {
    --  Position to open the terminal, this option is ignored if mode is tab
    position = "bot",
    -- window size, this option is ignored if tab is true
    size = 8,
  },
  float = {
    -- Key that close the code_runner floating window
    close_key = '<ESC>',
    -- Window border (see ':h nvim_open_win')
    border = "none",

    -- Num from `0 - 1` for measurements
    height = 0.8,
    width = 0.8,
    x = 0.5,
    y = 0.5,

    -- Highlight group for floating window/border (see ':h winhl')
    border_hl = "FloatBorder",
    float_hl = "Normal",

    -- Transparency (see ':h winblend')
    blend = 0,
  },
  filetype_path = "", -- No default path defined
  -- put here the commands by filetype
  filetype = {
    javascript = "node",
    java = "cd $dir && javac $fileName && time java $fileNameWithoutExt",
    c = "cd $dir && clang -g -Wextra -fsanitize=address -Wall -Wsign-compare -Wwrite-strings -Wtype-limits -Werror $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
    cpp = "cd $dir && clang++ -g -Wextra -fsanitize=address -Wall -Wsign-compare -Wwrite-strings -Wtype-limits -Werror $fileName -o $fileNameWithoutExt && time $dir/$fileNameWithoutExt",
    python = "time python3 -u",
    typescript = "time deno run",
    sh = "zsh",
    rust = "cd $dir && rustc $fileName && time $dir/$fileNameWithoutExt"
  },
  project_path = "", -- No default path defined
  project = {},
})
