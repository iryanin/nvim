local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "center",
			},
		},
		diagnostics = "nvim_lsp",
		-- 可选，显示 LSP 报错图标
		---@diagnostic disable-next-line: unused-local
		-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--   local s = " "
		--   for e, n in pairs(diagnostics_dict) do
		--     local sym = e == "error" and " " or (e == "warning" and " " or "")
		--     s = s .. n .. sym
		--   end
		--   return s
		-- end,
	},
})
