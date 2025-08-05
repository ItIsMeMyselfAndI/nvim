require("options")
vim.g.mapleader = " "

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.pack.add({
    { src = 'https://github.com/NMAC427/guess-indent.nvim' },
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/echasnovski/mini.pick' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' },
    { src = 'https://github.com/github/copilot.vim' },
    { src = 'https://github.com/tree-sitter-grammars/tree-sitter-markdown' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
    { src = 'https://github.com/ThePrimeagen/vim-be-good' },
    { src = 'https://github.com/Saghen/blink.cmp' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },
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
require("CopilotChat").setup({
    dependencies = {
        'Copilot.vim',
        'render-markdown.nvim',
    },
    window = {
        layout = 'vertical',
        width = 0.3,
        border = 'rounded',
        title = 'Copilot Chat',
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
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    file_types = { "markdown", "copilot-chat", "nvim-pack://6/confirm-update" },
})
require('blink.cmp').setup({
    keymap = { preset = 'default' },
    completion = { documentation = { auto_show = true } },
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
})

vim.lsp.config["markdownls"] = {
    cmd = { "vscode-markdown-language-server", "--stdio" },
    filetypes = { "markdown" },
    root_dir = require('lspconfig.util').root_pattern(".marksman.toml", "package.json", ".git"),
}
local servers = {
    "lua_ls", "ts_ls", "tailwindcss", "pyright",
    "cssls", "eslint", "html", "jsonls", "markdownls",
}
vim.lsp.enable(servers)
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        -- library = {
        --   vim.env.VIMRUNTIME,
        --   "${3rd}/luv/library",
        --   "${3rd}/busted/library",
        -- }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
for _, server in pairs(servers) do
    require('lspconfig')[server].setup({
        capabilities = require('blink.cmp').get_lsp_capabilities()
    })
end

vim.cmd("colorscheme tokyonight-night")

vim.keymap.set("n", "<leader>e", ":Oil<CR>")

vim.keymap.set({ "n", "v", "x" }, "<leader>w", "<Esc>:update<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>s", "<esc> :update<CR> :source<CR>")

vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fw", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fh", ":Pick help<CR>")

vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>")
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>")
vim.keymap.set("v", "<leader>co", ":CopilotChatOptimize<CR>")
vim.keymap.set("v", "<leader>cf", ":CopilotChatFix<CR>")
vim.keymap.set("v", "<leader>cs", ":CopilotChatSave<CR>")
vim.keymap.set("v", "<leader>cl", ":CopilotChatLoad<CR>")

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to [D]efinition" })
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to [I]mplementation" })
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "[R]eferences" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
