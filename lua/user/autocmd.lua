-- 进入Terminal 自动进入插入模式
local terGrp = vim.api.nvim_create_augroup("termOpen", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = terGrp,
  command = "startinsert",
})


local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- nvim-tree 自动关闭
local treeGrp = vim.api.nvim_create_augroup("nvimTreeClose", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  group = treeGrp,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd("quit")
    end
  end,
})

-- 用o换行不要延续注释
local commentGrp = vim.api.nvim_create_augroup("comment", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = commentGrp,
  pattern = "*",
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
  end,
})

local bpGrp = vim.api.nvim_create_augroup("bpGrp", { clear = true })
vim.api.nvim_create_autocmd("FileType",
  { pattern = { "c", "cpp", "go", "python", "lua" },
    group = bpGrp,
    command = ":lua require('user.dap.util').load_breakpoints()"
  })

local javaGrp = vim.api.nvim_create_augroup("javaGrp", { clear = true })
vim.api.nvim_create_autocmd("FileType",
  { pattern = { "java" },
    group = javaGrp,
    command = ":lua require('user.jdtls')"
  })
