return
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        {
            'nvim-lua/plenary.nvim',
            lazy = true,
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build =
            'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            config = function()
                require('telescope').load_extension('file_browser')
                local extensions = require('telescope').extensions.file_browser
                vim.keymap.set("n", "<leader>pv", extensions.file_browser)
                vim.keymap.set("n", "<leader>pd", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
            end,
        }
    },
    opts = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Find [P]roject [F]iles" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "[P]roject git files" })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help Tags" })
        vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>.', '<cmd>lua require("telescope.builtin").find_files({cwd = "%:h"})<CR>')
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find [f]iles in [B]uffer' })
        local opts = {
            pickers = {
                colorscheme = { enable_preview = true },
            },
        }
        return opts
    end,
}
