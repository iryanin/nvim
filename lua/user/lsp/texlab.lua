local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.texlab.setup({
  capabilities = capabilities,
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        args = { "-pdf", "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = true,
        onSave = true,
      },
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-g", "%l", "%p", "%f" },
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false,
      },
    },
  },
})
