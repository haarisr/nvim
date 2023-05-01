return
{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies =
    {
        "williamboman/mason-lspconfig.nvim", opts = {}
    },
    config = function()
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local get_servers = require('mason-lspconfig').get_installed_servers
        for _, server_name in ipairs(get_servers()) do
            local settings = {}
            if server_name == 'lua_ls' then
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                    }
                }
            end
            lspconfig[server_name].setup({
                capabilities = capabilities,
                settings = settings,
            })
        end

        local severity_levels = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        }

        local get_highest_error_severity = function(ns, bufnr)
            for _, level in ipairs(severity_levels) do
                local diags = vim.diagnostic.get(bufnr, { namespace = ns, severity = { min = level } })
                if #diags > 0 then
                    return level
                end
            end
        end
        vim.diagnostic.config({
            virtual_text = function(ns, bufnr)
                return {
                    spacing = 4,
                    prefix = "",
                    severity = { min = get_highest_error_severity(ns, bufnr) },
                    source = true,
                }
            end,
            float = true,
            signs = true,
            update_in_insert = false,
            underline = false,
            severity_sort = false,
        })
    end
}
