return
{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies =
    {
        { "williamboman/mason.nvim",           cmd = "Mason", opts = {} },
        { "williamboman/mason-lspconfig.nvim", opts = {} }
    },
    config = function()
        local lspconfig = require('lspconfig')
        -- local capabilities = vim.tbl_deep_extend( "force", vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        -- local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
        local servers = require('mason-lspconfig').get_installed_servers()
        for _, server_name in ipairs(servers) do
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
            if server_name == "pyright" then
                settings = {
                    pyright = {
                        -- disableLanguageServices = false,
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            typeCheckingMode = "strict",
                            useLibraryCodeForTypes = true,
                        },
                    },
                }
            end
            if server_name == "clangd" then
                capabilities.offsetEncoding = { "utf-16" }
            end

            if server_name == "ruff" then
                settings = {
                    lint = {
                        preview = true,
                    },
                    format = {
                        preview = true,
                    },
                    configurationPreference = "editorFirst",
                }
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    init_options = {
                        settings = settings,
                    },
                })
            else
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    settings = settings,
                })
            end
        end

        local severity_levels = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        }

        vim.diagnostic.config({
            virtual_text = {
                spacing = 4,
                prefix = "",
                source = true,
            },
            float = true,
            signs = true,
            update_in_insert = false,
            underline = false,
            severity_sort = false,
        })
    end
}
