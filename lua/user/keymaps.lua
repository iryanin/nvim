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

-- 命令行下 Ctrl+j/k  上一个下一个
map("c", "<C-j>", "<C-n>", { noremap = false })
map("c", "<C-k>", "<C-p>", { noremap = false })

map("n", "<leader>ww", ":wa<CR>", opts)
map("n", "<leader>wq", ":wqa<CR>", opts)

-- fix :set wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 上下滚动浏览
map("n", "<C-j>", "5j", opts)
map("n", "<C-k>", "5k", opts)
map("v", "<C-j>", "5j", opts)
map("v", "<C-k>", "5k", opts)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "10k", opts)
map("n", "<C-d>", "10j", opts)

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
-- 取消 s 默认功能
map("n", "s", "", opts)
map("n", "sv", ":vsp<CR>", opts)
map("n", "sh", ":sp<CR>", opts)
-- 关闭当前
map("n", "sc", "<C-w>c", opts)
-- 关闭其他
map("n", "so", "<C-w>o", opts) -- close others
-- alt + hjkl  窗口之间跳转
--map("n", "<A-h>", "<C-w>h", opts)
--map("n", "<A-j>", "<C-w>j", opts)
--map("n", "<A-k>", "<C-w>k", opts)
--map("n", "<A-l>", "<C-w>l", opts)
-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<C-w>h", opts)
map("n", "<leader>j", "<C-w>j", opts)
map("n", "<leader>k", "<C-w>k", opts)
map("n", "<leader>l", "<C-w>l", opts)
-- 左右比例控制
map("n", "<A-h>", ":vertical resize -2<CR>", opts)
map("n", "<A-l>", ":vertical resize +2<CR>", opts)
--map("n", "s,", ":vertical resize -10<CR>", opts)
--map("n", "s.", ":vertical resize +10<CR>", opts)
-- 上下比例
--map("n", "sj", ":resize +10<CR>", opts)
--map("n", "sk", ":resize -10<CR>", opts)
map("n", "<A-k>", ":resize +2<CR>", opts)
map("n", "<A-j>", ":resize -2<CR>", opts)
-- 相等比例
map("n", "s=", "<C-w>=", opts)

-- Terminal相关
map("n", "st", ":sp | terminal<CR>", opts)
map("n", "stv", ":vsp | terminal<CR>", opts)
-- Esc 回 Normal 模式
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opts)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opts)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opts)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opts)
map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opts)
map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opts)
map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opts)
map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opts)
--------------------------------------------------------------------

-- treesitter 折叠
map("n", "zc", ":foldclose<CR>", opts)
map("n", "zo", ":foldopen<CR>", opts)

-- nvim-tree
--map("n", "<A-m>", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>m", ":NvimTreeToggle<CR>", opts)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opts)
-- "moll/vim-bbye" 关闭当前 buffer
map("n", "<leader>bc", ":bdelete!<CR>", opts)
--map("n", "<C-w>", ":bdelete!<CR>", opts)
-- 关闭左/右侧标签页
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
-- 关闭其他标签页
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opts)
-- 关闭选中标签页
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opts)

-- Telescope
map("n", "<C-p>", ":Telescope find_files<CR>", opts)
map("n", "<C-f>", ":Telescope live_grep<CR>", opts)

--lsp
--outline
map("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)
map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
-- map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
-- code action
map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
-- map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
-- go xx
map("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
-- map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
map("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)
-- map("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opts)
map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
-- map("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
-- diagnostic
map("n", "gp", ":lua vim.diagnostic.open_float()<CR>", opts)
map("n", "gk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
-- map("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "gj", ":lua vim.diagnostic.goto_next()<CR>", opts)
-- map("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
map("n", "<leader>f", ":lua vim.lsp.buf.format({async=true})<CR>", opts)
--autosave
map("n", "<leader>n", ":ASToggle<CR>", opts)

local pluginKeys = {}

pluginKeys.nvimTreeList = { -- 打开文件或文件夹
	{ key = { "o", "<CR>", "<2-LeftMouse>" }, action = "edit" },
	-- v分屏打开文件
	{ key = "v", action = "vsplit" },
	-- h分屏打开文件
	{ key = "h", action = "split" },
	-- Ignore (node_modules)
	{ key = "I", action = "toggle_ignored" },
	-- Hide (dotfiles)
	{ key = ".", action = "toggle_dotfiles" },
	{ key = "R", action = "refresh" },
	-- 文件操作
	{ key = "n", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "y", action = "copy_name" },
	{ key = "Y", action = "copy_path" },
	{ key = "gy", action = "copy_absolute_path" },
	{ key = "i", action = "toggle_file_info" },
	-- 进入下一级
	{ key = { "]" }, action = "cd" },
	-- 进入上一级
	{ key = { "[" }, action = "dir_up" },
}
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<C-n>"] = "move_selection_next",
		["<C-p>"] = "move_selection_previous",
		-- 历史记录
		["<Down>"] = "cycle_history_next",
		["<Up>"] = "cycle_history_prev",
		-- 关闭窗口
		-- ["<esc>"] = actions.close,
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}
-- 代码注释插件
-- see ./lua/plugin-config/comment.lua
pluginKeys.comment = {
	-- Normal 模式快捷键
	toggler = {
		line = "gcc", -- 行注释
		block = "gbc", -- 块注释
	},
	-- Visual 模式
	opleader = {
		line = "gc",
		bock = "gb",
	},
}
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local luasnip = require("luasnip")
	local cmp = require("cmp")
	return {
		-- 出现补全
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({
			select = false,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		-- 自定义代码段跳转到下一个参数
		["<C-l>"] = cmp.mapping(function(_)
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),

		-- 自定义代码段跳转到上一个参数
		["<C-h>"] = cmp.mapping(function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- elseif luasnip.expand_or_jumpable() then
				-- luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				-- elseif luasnip.jumpable(-1) then
				-- luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}
end

-- nvim-dap
pluginKeys.mapDAP = function()
	map(
		"n",
		"<leader>de",
		":lua require'dap'.close()<CR>"
			.. ":lua require'dap'.terminate()<CR>"
			.. ":lua require'dap.repl'.close()<CR>"
			.. ":lua require'dapui'.close()<CR>"
			.. ":lua require('dap').clear_breakpoints()<CR>"
			.. "<C-w>o<CR>",
		opts
	)
	-- 继续
	map("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opts)
	-- 设置断点
	map(
		"n",
		"<leader>dt",
		":lua require('dap').toggle_breakpoint();require'user.dap.util'.store_breakpoints(true)<CR>",
		opts
	)
	map(
		"n",
		"<leader>dT",
		":lua require('dap').clear_breakpoints();require'user.dap.util'.store_breakpoints(true)<CR>",
		opts
	)
	--  stepOver, stepOut, stepInto
	map("n", "<leader>dj", ":lua require'dap'.step_over()<CR>", opts)
	map("n", "<leader>dk", ":lua require'dap'.step_out()<CR>", opts)
	map("n", "<leader>dl", ":lua require'dap'.step_into()<CR>", opts)
	-- 弹窗
	map("n", "<leader>dh", ":lua require'dapui'.eval()<CR>", opts)
end
-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "<leader>gj", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map("n", "<leader>gk", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
	map("n", "<leader>gS", gs.stage_buffer)
	map("n", "<leader>gu", gs.undo_stage_hunk)
	map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
	map("n", "<leader>gR", gs.reset_buffer)
	map("n", "<leader>gp", gs.preview_hunk)
	map("n", "<leader>gb", function()
		gs.blame_line({ full = true })
	end)
	map("n", "<leader>gd", gs.diffthis)
	map("n", "<leader>gD", function()
		gs.diffthis("~")
	end)
	-- toggle
	map("n", "<leader>gtd", gs.toggle_deleted)
	map("n", "<leader>gtb", gs.toggle_current_line_blame)
	-- Text object
	map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
end
return pluginKeys
