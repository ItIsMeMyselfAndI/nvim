return {
    {
        "akinsho/flutter-tools.nvim",
        lazy = false, -- We don't want to lazy load this, we want it ready when opening Dart files
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- Optional: Makes the device selection UI look much better
        },
        config = function()
            require("flutter-tools").setup {
                ui = {
                    -- The border type for the floating window
                    border = "rounded",
                },
                decorations = {
                    statusline = {
                        -- Shows the connected device in your lualine/statusline
                        app_version = true,
                        device = true,
                    }
                },
                -- This connects flutter-tools to your built-in Neovim LSP
                lsp = {
                    settings = {
                        showTodos = true,
                        completeFunctionCalls = true,
                    }
                }
            }
        end,
    }
}
