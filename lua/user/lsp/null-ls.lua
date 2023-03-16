local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.formatting.black,
    },
    -- on_attach = function(client)
    --     if client.server_capabilities.documentFormattingProvider then
    --         vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async=true})")
    --     end
    -- end,
})
