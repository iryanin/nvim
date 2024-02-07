-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = {
    noremap = true,
    silent = true,
}

-- 本地变量
local map = vim.api.nvim_set_keymap

-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opts)
map("v", "g_", "$", opts)
map("n", "$", "g_", opts)
map("n", "g_", "$", opts)

map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>ww", ":wa<CR>", opts)
map("n", "<leader>wq", ":wqa<CR>", opts)

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
-- map("n", "<C-j>", "5j", opts)
-- map("n", "<C-k>", "5k", opts)
-- map("v", "<C-j>", "5j", opts)
-- map("v", "<C-k>", "5k", opts)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "10k", opts)
map("n", "<C-d>", "10j", opts)
map("v", "<C-u>", "10k", opts)
map("v", "<C-d>", "10j", opts)

-- magic search
map("n", "/", "/\\m", { noremap = true, silent = false })
map("v", "/", "/\\m", { noremap = true, silent = false })

-- visual模式下缩进代码
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opts)
map("v", "K", ":move '<-2<CR>gv-gv", opts)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opts)

-- 退出
map("n", "<leader>qq", ":qa<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)

-- insert 模式下，跳到行首行尾
-- map("i", "<C-h>", "<ESC>I", opts)
-- map("i", "<C-l>", "<ESC>A", opts)

------------------------------------------------------------------
-- windows 分屏快捷键
------------------------------------------------------------------
map("n", "q", "", opts)
map("v", "q", "", opts)
-- 取消 s 默认功能
map("n", "s", "", opts)
map("n", "sv", ":vsp<CR>", opts)
map("n", "sh", ":sp<CR>", opts)
-- 关闭当前
map("n", "sc", "<C-w>c", opts)
-- 关闭其他
map("n", "so", "<C-w>o", opts) -- close others
-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<C-w>h", opts)
map("n", "<leader>j", "<C-w>j", opts)
map("n", "<leader>k", "<C-w>k", opts)
map("n", "<leader>l", "<C-w>l", opts)
-- 左右比例控制
-- map("n", "s,", ":vertical resize -10<CR>", opts)
-- map("n", "s.", ":vertical resize +10<CR>", opts)
-- 上下比例
-- map("n", "sj", ":resize +10<CR>", opts)
-- map("n", "sk", ":resize -10<CR>", opts)
-- 相等比例
map("n", "s=", "<C-w>=", opts)

--------------------------------------------------------------------

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>", opts)
map("n", "zo", ":foldopen<CR>", opts)

-- nvim-tree
map("n", "<leader>m", ":NvimTreeToggle<CR>", opts)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opts)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>bc", ":bdelete!<CR>", opts)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opts)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opts)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>lg", ":Telescope live_grep<CR>", opts)

--lsp
--outline
map("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
-- -- code action
map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
-- -- go xx
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
-- -- diagnostic
map("n", "gp", ":lua vim.diagnostic.open_float()<CR>", opts)
map("n", "gk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "gj", ":lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<leader>f", ":lua vim.lsp.buf.format({async=true})<CR>", opts)
--autosave
map("n", "<leader>n", ":ASToggle<CR>", opts)
--markdown-preview
map("n", "<leader>mp", ":MarkdownPreview<CR>", opts)
map("n", "<leader>rf", ":RunFile<CR>", opts)
map("n", "<leader>rs", ":RunCode<CR>", opts)
map("n", "<leader>rp", ":RunProject<CR>", opts)
map("n", "<leader>rc", ":RunClose<CR>", opts)
--dap
map(
    "n",
    "<leader>dq",
    ":lua require'dap'.close()<CR>"
    .. ":lua require'dap'.terminate()<CR>"
    .. ":lua require'dap.repl'.close()<CR>"
    .. ":lua require'dapui'.close()<CR>"
    .. ":lua require('dap').clear_breakpoints()<CR>",
    opts
)
-- 继续
map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opts)
-- 设置断点
map("n", "<leader>db", ":lua require('dap').toggle_breakpoint();require'user.util'.store_breakpoints(true)<CR>", opts)
map("n", "<leader>dB", ":lua require('dap').clear_breakpoints();require'user.util'.store_breakpoints(true)<CR>", opts)
--  stepOver, stepOut, stepInto
map("n", "<leader>dn", ":lua require'dap'.step_over()<CR>", opts)
map("n", "<leader>df", ":lua require'dap'.step_out()<CR>", opts)
map("n", "<leader>ds", ":lua require'dap'.step_into()<CR>", opts)
-- 弹窗
map("n", "<leader>de", ":lua require'dapui'.eval()<CR>", opts)
