return
{
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
    },
    -- opts = function()
    --     -- Remaps for the refactoring operations currently offered by the plugin
    --     vim.keymap.set("v", "<leader>re",
    --         function() require('refactoring').refactor('Extract Function') end,
    --         { noremap = true, silent = true, expr = false })
    --     vim.keymap.set("v", "<leader>rf",
    --         function() require('refactoring').refactor('Extract Function To File') end,
    --         { noremap = true, silent = true, expr = false })
    --     vim.keymap.set("v", "<leader>rv",
    --         function() require('refactoring').refactor('Extract Variable') end,
    --         { noremap = true, silent = true, expr = false })
    --     vim.keymap.set("v", "<leader>ri",
    --         function() require('refactoring').refactor('Inline Variable') end,
    --         { noremap = true, silent = true, expr = false })
    --
    --     -- Extract block doesn't need visual mode
    --     vim.keymap.set("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end,
    --         { noremap = true, silent = true, expr = false })
    --     vim.keymap.set("n", "<leader>rbf",
    --         function() require('refactoring').refactor('Extract Block To File') end,
    --         { noremap = true, silent = true, expr = false })
    --
    --     -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    --     vim.keymap.set("n", "<leader>ri", function() require('refactoring').refactor('Inline Variable') end,
    --         { noremap = true, silent = true, expr = false })
    --
    --     -- You can also use below = true here to to change the position of the printf
    --     -- statement (or set two remaps for either one). This remap must be made in normal mode.
    --     -- vim.keymap.set(
    --     --     "n",
    --     --     "<leader>rp",
    --     --     function() require('refactoring').debug.printf({ below = false }) end,
    --     --     { noremap = true }
    --     -- )
    --
    --     -- Print var
    --
    --     -- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
    --     vim.keymap.set("n", "<leader>rp", function() require('refactoring').debug.print_var({ normal = true }) end,
    --         { noremap = true })
    --     -- Remap in visual mode will print whatever is in the visual selection
    --     -- vim.keymap.set("v", "<leader>rv", function() require('refactoring').debug.print_var({}) end,
    --     --     { noremap = true })
    --
    --     -- Cleanup function: this remap should be made in normal mode
    --     vim.keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end,
    --         { noremap = true })
    -- end,
    keys =
    {
        { "<leader>re",  function() require('refactoring').refactor('Extract Function') end,         mode = "v", desc = "Extract Function" },
        { "<leader>rf",  function() require('refactoring').refactor('Extract Function To File') end, mode = "v", desc = "Extract Function To File" },
        { "<leader>rv",  function() require('refactoring').refactor('Extract Variable') end,         mode = "v", desc = "Extract Variable" },
        { "<leader>ri",  function() require('refactoring').refactor('Inline Variable') end,          mode = "v", desc = "Inline Variable" },
        { "<leader>rb",  function() require('refactoring').refactor('Extract Block') end,            mode = "n", desc = "Extract Block" },
        { "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end,    mode = "n", desc = "Extract Block To File" },
        { "<leader>ri",  function() require('refactoring').refactor('Inline Variable') end,          mode = "n", desc = "Inline Variable" },
        { "<leader>rp",  function() require('refactoring').debug.print_var({ normal = true }) end,   mode = "n", desc = "Print var" },
        { "<leader>rc",  function() require('refactoring').debug.cleanup({}) end,                    mode = "n", desc = "Cleanup function" },
    },
}
