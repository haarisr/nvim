return
{
    -- linting and formatiing
    "nvimtools/none-ls.nvim",
    enabled = false,
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    main = "null-ls",
    opts = function()
        local null_ls = require("null-ls")

        local sources = {
            null_ls.builtins.completion.spell,
            --        null_ls.builtins.formatting.stylua,
        }
        return {
            sources = sources,
            default_timeout = 10000,
        }
    end,
}
