return {
    "folke/which-key.nvim",
    opts = {},
    config = function()
        require("which-key").setup({
            plugins = {
                spelling = { enabled = true },
            },
        })
    end
}
