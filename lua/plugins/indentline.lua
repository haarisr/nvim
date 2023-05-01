return
{
    'lukas-reineke/indent-blankline.nvim',
    name = "indent_blankline",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        show_current_context = false,
        show_current_context_start = false,
        char = '┊',
        show_trailing_blankline_indent = false,
    },
}
