return
{
    "zbirenbaum/copilot.lua",
     cmd = "Copilot",
    event = "BufReadPre",
    opts = {
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = false,
            auto_trigger = true,
            keymap = {},
        },
        filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
        },
        copilot_node_command = 'node',     -- Node.js version must be > 16.x
        server_opts_overrides = {
            settings = {
                advanced = {
                    inlineSuggestCount = 100,
                    listCount = 10,
                    length = 100,
                },
            },
        },
    },
}
