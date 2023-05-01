return
{
    'theprimeagen/harpoon',
    name = 'harpoon',
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon Add Mark File" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon Toggle Quick Menu" })

        vim.keymap.set("n", "<space>1", function() ui.nav_file(1) end, { desc = "Harpoon File 1" })
        vim.keymap.set("n", "<space>2", function() ui.nav_file(2) end, { desc = "Harpoon File 2" })
        vim.keymap.set("n", "<space>3", function() ui.nav_file(3) end, { desc = "Harpoon File 3" })
        vim.keymap.set("n", "<space>4", function() ui.nav_file(4) end, { desc = "Harpoon File 4" })

        local opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 4,
            }
        }
        return opts
    end,
}
