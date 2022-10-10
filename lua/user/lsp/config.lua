local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
require("lspconfig")["pyright"].setup({
	on_attach = function(client)
		-- 禁用格式化功能，交给专门插件插件处理
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	flags = lsp_flags,
})
require("lspconfig")["clangd"].setup({
	on_attach = function(client)
		-- 禁用格式化功能，交给专门插件插件处理
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	flags = lsp_flags,
})
