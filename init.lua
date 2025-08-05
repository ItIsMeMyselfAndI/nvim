SERVERS = {
    "lua_ls", "ts_ls", "tailwindcss", "pyright",
    "cssls", "eslint", "html", "jsonls", "markdownls",
}

vim.g.mapleader = " "

require("options")
require("plugins")
require("plugins.configs")
require("plugins.keymaps")

vim.lsp.enable(SERVERS)

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "copilot-chat", "nvim-pack://6/confirm-update" },
    callback = function()
        vim.bo.filetype = "markdown"
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- vim.cmd("wincmd L")
        -- vim.cmd("vertical resize 50")
    end,
})
vim.ui.select = require('mini.pick').ui_select

vim.keymap.set({ "n", "v", "x" }, "<leader>w", "<Esc>:update<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>s", "<esc> :update<CR> :source<CR>")
