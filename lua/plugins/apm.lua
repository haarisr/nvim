return
{

    "ThePrimeagen/vim-apm",
    config = function()
        local apm = require("vim-apm")
        apm:setup({})
    end,
    keys = function()
        local apm = require("vim-apm")
        return {
            { "<leader>apm", function() apm:toggle_monitor() end, desc = "Toggle APM" }
        }
    end
}
