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
            if server_name == "pyright" or server_name == "basedpyright" then
                -- settings = {
                --     pyright = {
                --         disableOrganizeImports = true,
                --     },
                --     python = {
                --         analysis = {
                --             typeCheckingMode = "standard",
                --             useLibraryCodeForTypes = true,
                --         },
                --     },
                -- }
            end
            if server_name == "clangd" then
                capabilities.offsetEncoding = { "utf-16" }
            end

            lspconfig[server_name].setup({
                capabilities = capabilities,
                settings = settings,
            })
        end

        -- vim.api.nvim_create_autocmd('FileType', {
        --     -- This handler will fire when the buffer's 'filetype' is "python"
        --     pattern = 'python',
        --     callback = function(args)
        --         vim.lsp.start({
        --             name = 'red_knot',
        --             cmd = { '/home/haaris/ruff/target/debug/red_knot', '--current-directory', '.', '--watch', '-vv', 'server' },
        --             -- Set the "root directory" to the parent directory of the file in the
        --             -- current buffer (`args.buf`) that contains either a "setup.py" or a
        --             -- "pyproject.toml" file. Files that share a root directory will reuse
        --             -- the connection to the same LSP server.
        --             root_dir = vim.fs.root(args.buf, { 'setup.py', 'pyproject.toml' }),
        --         })
        --     end,
        -- })


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
