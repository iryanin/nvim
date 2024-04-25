vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = {
    noremap = true,
    silent = true,
}

local map = vim.api.nvim_set_keymap

-- $跳到行尾不带空格 (交换$ 和 g_)
map("v", "$", "g_", opts)
map("v", "g_", "$", opts)
map("n", "$", "g_", opts)
map("n", "g_", "$", opts)

-- map("n", "<leader>q", ":q<CR>", opts)
-- map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>ww", ":wa<CR>", opts)
map("n", "<leader>wq", ":wqa<CR>", opts)
map("n", "<leader>qq", ":qa<CR>", opts)
-- map("n", "<leader>wqa", ":wqa<CR>", opts)

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- magic search
map("n", "/", "/\\m", { noremap = true, silent = false })
map("v", "/", "/\\m", { noremap = true, silent = false })

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opts)
map("v", "K", ":move '<-2<CR>gv-gv", opts)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opts)

map("n", "q", "", opts)
map("v", "q", "", opts)

map("n", "s", "", opts)
map("n", "sv", ":vsp<CR>", opts)
map("n", "sh", ":sp<CR>", opts)
-- close current
map("n", "sc", "<C-w>c", opts)
-- close others
map("n", "so", "<C-w>o", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
-- 左右比例控制
-- map("n", "s,", ":vertical resize -10<CR>", opts)
-- map("n", "s.", ":vertical resize +10<CR>", opts)
-- 上下比例
-- map("n", "sj", ":resize +10<CR>", opts)
-- map("n", "sk", ":resize -10<CR>", opts)
-- 相等比例
-- map("n", "s=", "<C-w>=", opts)

map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>", opts)
map("n", "zo", ":foldopen<CR>", opts)

-- nvim-tree
map("n", "<leader>m", ":NvimTreeToggle<CR>", opts)

map("n", "U", ":Telescope undo<cr>", opts)

-- bufferline
-- 左右Tab切换
map("n", "<leader>h", ":BufferLineCyclePrev<CR>", opts)
map("n", "<leader>l", ":BufferLineCycleNext<CR>", opts)
map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
map("n", "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", opts)

-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>bc", ":Bdelete!<CR>", opts)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opts)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opts)

map('t', '<esc>', [[<C-\><C-n>]], opts)
map('t', 'jk', [[<C-\><C-n>]], opts)
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
-- vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
-- map("n", "<leader>fs", ":lua require'auto-session.session-lens'.search_session()<CR>", opts)
-- map("n", "<leader>fs", ":Telescope session-lens<CR>", opts)

-- persistence.nvim
-- restore the session for the current directory
vim.api.nvim_set_keymap("n", "<leader>sc", [[<cmd>lua require("persistence").load()<cr>]], {})
-- restore the last session
vim.api.nvim_set_keymap("n", "<leader>sl", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})
-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap("n", "<leader>ss", [[<cmd>lua require("persistence").stop()<cr>]], {})

--lsp
--outline
map("n", "<leader>o", "<cmd>Outline<CR>", opts)
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
-- -- code action
map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
-- -- go xx
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
-- -- diagnostic
map("n", "gp", ":lua vim.diagnostic.open_float()<CR>", opts)
map("n", "gk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "gj", ":lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<leader>f", ":lua vim.lsp.buf.format({async=true})<CR>", opts)
--autosave
-- map("n", "<leader>ss", ":ASToggle<CR>", opts)
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
