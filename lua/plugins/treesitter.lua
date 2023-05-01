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
    },
    opts =
    {
        ensure_installed = { "c", "lua", "vim", "python", "help" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-s>",
                node_incremental = "<C-s>",
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
        },
    },
    keys = {
        { "<c-s>", desc = "Increment selection" },
        { "<bs>",  desc = "Decrement selection", mode = "x" },
    },
}
