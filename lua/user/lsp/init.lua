local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.ui")
require("user.lsp.clangd")
require("user.lsp.pyright")
require("user.lsp.sumneko-lua")
-- require("user.lsp.jdtls")
require("user.lsp.texlab")
