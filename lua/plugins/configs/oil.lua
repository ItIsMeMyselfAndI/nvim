require("oil").setup({
    columns = { "icon" },
    win_options = {
        wrap = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
        cursorline = true,
    },
    view_options = { show_hidden = true },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "oil",
    callback = function()
    end,
})
