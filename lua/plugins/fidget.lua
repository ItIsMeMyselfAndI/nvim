return {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({
            window = {
                border = "rounded",
            },
            integration = {
                ["nvim-tree"] = {
                    enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
                },
            },
        })
    end
}
