return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'brenoprata10/nvim-highlight-colors',
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'default',
        },
        columns = { "kind_icon", "label", "label_detail", "source_name", gap = 1 },
        completion = {
            documentation = {
                auto_show = true
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
    },
    opts_extend = { "sources.default" },
    config = function()
        require("blink.cmp").setup {
            completion = {
                ghost_text = { enabled = true, },
                menu = {
                    draw = {
                        columns = {
                            { "kind_icon", "label",       "label_description", gap = 1 },
                            { "kind",      "source_name", gap = 1 },
                        },
                        components = {
                            -- customize the drawing of kind icons
                            label_description = {
                                width = { max = 50 },
                            },
                            source_name = {
                                text = function(ctx)
                                    return "[" .. ctx.source_name .. "]"
                                end,
                            },
                            kind_icon = {
                                text = function(ctx)
                                    -- default kind icon
                                    local icon = ctx.kind_icon
                                    -- if LSP source, check for color derived from documentation
                                    if ctx.item.source_name == "LSP" then
                                        local color_item = require("nvim-highlight-colors").format(
                                            ctx.item.documentation, { kind = ctx.kind })
                                        if color_item and color_item.abbr ~= "" then
                                            icon = color_item.abbr
                                        end
                                    end
                                    return icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    -- default highlight group
                                    local highlight = "BlinkCmpKind" .. ctx.kind
                                    -- if LSP source, check for color derived from documentation
                                    if ctx.item.source_name == "LSP" then
                                        local color_item = require("nvim-highlight-colors").format(
                                            ctx.item.documentation, { kind = ctx.kind })
                                        if color_item and color_item.abbr_hl_group then
                                            highlight = color_item.abbr_hl_group
                                        end
                                    end
                                    return highlight
                                end,
                            },
                        },
                    },
                },
            },
        }
    end
}
