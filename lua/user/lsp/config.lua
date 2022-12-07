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
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = "none",
          reportOptionalMemberAccess = "none",
          reportOptionalSubscript = "none",
          reportPrivateImportUsage = "none",
        },
      },
    },
  },
})
require("lspconfig").texlab.setup({
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  settings = {
    texlab = {
      build = {
        args = { "-pdf", "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = true,
      },
      forwardSearch = {
        executable = "evince",
        args = { "%p" },
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
require("lspconfig").sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
