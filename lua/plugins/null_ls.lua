local on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.notify("Formatting...")
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

return
{
    -- linting and formatiing
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        local sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.flake8,
            null_ls.builtins.completion.spell,
            null_ls.builtins.formatting.isort,
            --        null_ls.builtins.formatting.stylua,
        }

        null_ls.setup({
            sources = sources,
            on_attach = on_attach,
            default_timeout = 10000,
        })
    end,
}
