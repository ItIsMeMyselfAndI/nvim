return {
    "j-hui/fidget.nvim",
    opts = {
        notification = {
            window = {
                border = "rounded",
                x_padding = 1,
                y_padding = 1,
            },
        },
        integration = {
            ["nvim-tree"] = {
                enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
            },
        },

    }
}
