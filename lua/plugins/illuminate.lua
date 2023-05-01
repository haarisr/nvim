return
{
    "RRethy/vim-illuminate",
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function ()
        require("illuminate").configure()
    end,
}
