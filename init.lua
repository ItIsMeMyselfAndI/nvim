vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.hlsearch = false

vim.o.wrap = false
vim.o.swapfile = false

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.undofile = true

vim.splitright = true
vim.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '.', nbsp = '␣' }

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.pack.add({
    { src = 'https://github.com/NMAC427/guess-indent.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/stevearc/oil.nvim' },
})
require("mini.pick").setup()
require("gitsigns").setup({
})
require("oil").setup({
    git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
            return false
        end,
        mv = function(src_path, dest_path)
            return false
        end,
        rm = function(path)
            return false
        end,
    },
})

vim.lsp.enable({
    "lua_ls",
    "ts_ls",
    "tailwindcss",
    "pyright"
})
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
                true, client.id, ev.buf,
                { autotrigger = true })
        end
    end
})
vim.cmd("set completeopt+=noselect")

vim.cmd("colorscheme tokyonight-night")

vim.keymap.set({ "n", "v", "x" }, "<leader>w", "<Esc>:w<CR>")

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>sf", ":Pick files<CR>")
vim.keymap.set("n", "<leader>sw", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
