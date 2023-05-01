vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    end,
    desc = "Mappings for navigation with a terminal",
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, remap = false }

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold" }, {
                buffer = ev.buf,
                group = group,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                buffer = ev.buf,
                group = group,
                callback = function()
                    vim.lsp.buf.clear_references()
                end,
            })
        end
    end,
})


-- vim.api.nvim_create_autocmd("FileType", {
--     group = vim.api.nvim_create_augroup('Closewith_q', {}),
--     pattern = {
--         "PlenaryTestPopup",
--         "alpha",
--         "dashboard",
--         "fugitive",
--         "help",
--         "lspinfo",
--         "man",
--         "mason",
--         "notify",
--         "qf",
--         "spectre_panel",
--         "startuptime",
--         "tsplayground",
--     },
--     callback = function(event)
--         vim.bo[event.buf].buflisted = false
--         vim.keymap.set(
--             "n",
--             "q",
--             "<cmd>close<cr>",
--             { buffer = event.buf, silent = true }
--         )
--     end,
-- })
