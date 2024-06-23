return
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",     -- Required
            "hrsh7th/cmp-buffer",       -- Optional
            "hrsh7th/cmp-path",         -- Optional
            "saadparwaiz1/cmp_luasnip", -- Optional
            "hrsh7th/cmp-nvim-lua",     -- Optional
        },
        {
            "zbirenbaum/copilot-cmp",
            dependencies = "copilot.lua",
            main = "copilot_cmp",
            enabled = false,
            config = true,
        },
        {
            "L3MON4D3/LuaSnip",            -- Required
            "rafamadriz/friendly-snippets" -- Optional
        },
        {
            "windwp/nvim-autopairs",
            config = true,
        },
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end
        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.Item,
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-w>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() and has_words_before() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            matching = {
                disallow_fuzzy_matching = true,
                disallow_fullfuzzy_matching = true,
                disallow_partial_fuzzy_matching = true,
                disallow_partial_matching = true,
                disallow_prefix_unmatching = false,
            },
            sources = {
                { name = "copilot", keyword_length = 0 },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "path" },
                { name = "buffer",  keyword_length = 5 },
                { name = "luasnip" },
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    local short_name = {
                        copilot = "Copilot",
                        nvim_lsp = "LSP",
                        nvim_lua = "Lua",
                        buffer = "Buffer",
                        lua_snip = "Snippet",
                    }
                    local menu_name = short_name[entry.source.name] or entry.source.name
                    item.menu = string.format("[%s]", menu_name)
                    return item
                end,
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    -- require("copilot_cmp.comparators").prioritize,

                    -- Below is the default comparitor list and order for nvim-cmp
                    cmp.config.compare.offset,
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    function(entry1, entry2)
                        local _, entry1_under = entry1.completion_item.label:find "^_+"
                        local _, entry2_under = entry2.completion_item.label:find "^_+"
                        entry1_under = entry1_under or 0
                        entry2_under = entry2_under or 0
                        if entry1_under > entry2_under then
                            return false
                        elseif entry1_under < entry2_under then
                            return true
                        end
                    end,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                    --
                },
            },
        }
        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
}
