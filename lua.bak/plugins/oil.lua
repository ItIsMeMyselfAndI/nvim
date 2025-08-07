return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
        require("oil").setup({
            columns = { "icon" },
            win_options = {
                wrap = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                cursorline = true,
            },
            view_options = { show_hidden = true },
        })
    end
}
