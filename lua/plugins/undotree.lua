return
{
    "mbbill/undotree",
    name = "undotree",
    opts = {},
    config = function()
    end,
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, mode = "n", desc = "Undotree Toggle" },
    },
}
