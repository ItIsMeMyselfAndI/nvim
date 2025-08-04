vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true

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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"


vim.opt.fillchars = {
  vert = '┃',      -- Vertical split
  horiz = '━',     -- Horizontal split
}

vim.pack.add({
    { src = 'https://github.com/NMAC427/guess-indent.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' },
})
require("mini.pick").setup()
require("gitsigns").setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
})
require("oil").setup()
require("CopilotChat").setup({
    window = {
        layout = 'vertical',
        width = 0.3,        -- Fixed width in columns
        border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
        title = 'Copilot Chat',
        col = 'right',
    },
    headers = {
        user = '  User ',
        assistant = '  Copilot ',
        error = '  Error ',
        tool = '🛠 Tool: ',
    },
    context = "buffers",
    highlight_selection = true,
    separator = '━━',
    show_folds = false,
})
vim.ui.select = require('mini.pick').ui_select

vim.lsp.config('css_ls', { cmd = "vscode-css-language-server" })
vim.lsp.config('eslint_ls', { cmd = "vscode-eslint-language-server" })
vim.lsp.config('html_ls', { cmd = "vscode-eslint-language-server" })
vim.lsp.config('json_ls', { cmd = "vscode-json-language-server" })
vim.lsp.config('markdown_ls', { cmd = "vscode-markdown-language-server" })
vim.lsp.enable({
    "lua_ls", "ts_ls", "tailwindcss", "pyright",
    "css_ls", "eslint_ls", "html_ls", "json_ls", "markdown_ls",
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

vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>w", "<Esc>:update<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>s", "<esc> :update<CR> :source<CR>")
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>sf", ":Pick files<CR>")
vim.keymap.set("n", "<leader>sw", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
vim.keymap.set("n", "<leader>c", ":CopilotChatToggle<CR>",
    { silent = true, desc = "Open Copilot Chat" })

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to [D]efinition" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to [I]mplementation" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[R]eferences" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
