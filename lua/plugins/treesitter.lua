return
{
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    dependencies =
    {
        'nvim-treesitter/playground',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
    },
    opts =
    {
        ensure_installed = { "c", "lua", "vim", "python", "vimdoc" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = "<nop>",
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                }
            },
            -- swap = {
            --     enable = true,
            --     swap_next = {
            --         ['<leader>a'] = '@parameter.inner',
            --     },
            --     swap_previous = {
            --         ['<leader>A'] = '@parameter.inner',
            --     },
            -- },
            lsp_interop = {
                enable = true,
                border = 'none',
                peek_definition_code = {
                    ['<leader>df'] = '@function.outer',
                    ['<leader>dF'] = '@class.outer',
                },
            },
        },
    },
    keys = {
        { "<c-s>", desc = "Increment selection" },
        { "<bs>",  desc = "Decrement selection", mode = "x" },
    },
}
