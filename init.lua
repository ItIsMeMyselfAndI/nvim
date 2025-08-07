vim.g.mapleader = " "

SERVERS = { "lua_ls", "ts_ls", "tailwindcss", "cssls", "html", "markdown_oxide", "pyright", "zk", "eslint" }

vim.o.number = true
vim.o.relativenumber = true

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

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

vim.diagnostic.config({
    virtual_text = {
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd [[colorscheme tokyonight-night]]
        end
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        lazy = true,
        config = function()
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
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "bash", "c", "cpp", "css", "diff", "dockerfile",
                    "git_config", "git_rebase", "gitattributes", "gitcommit",
                    "go", "html", "javascript", "json", "json5",
                    "lua", "markdown", "markdown_inline", "python",
                    "regex", "rust", "scss", "sql",
                    "toml", "typescript", "vimdoc", "yaml"
                },
                sync_install = false,
                ignore_install = {},
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        config = function()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
                file_types = { "markdown", "copilot-chat", "nvim-pack://6/confirm-update" },
            })
        end
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = {
                preset = 'default',
            },
            completion = {
                documentation = {
                    auto_show = true
                }
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            opts_extend = { "sources.default" }
        },
    },
    {
        "mason-org/mason.nvim",
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                dependencies = { 'saghen/blink.cmp' },
            },
            { "artemave/workspace-diagnostics.nvim" },
        },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = { vim.env.VIMRUNTIME }
                                -- library = vim.api.nvim_get_runtime_file("", true),
                            },
                        },
                    },
                },
                ts_ls = {},
                tailwindcss = {},
                cssls = {},
                html = {},
                markdown_oxide = {},
                pyright = {},
                zk = {},
                eslint = {},
            },
        },
        config = function(_, opts)
            require("mason").setup({
                ensure_installed = SERVERS
            })
            for server, config in pairs(opts.servers) do
                config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                config.on_attach = function(client, bufnr)
                    require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
                end
                require('lspconfig')[server].setup(config)
            end
        end
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
            { "github/copilot.vim" }
        },
        build = "make tiktoken",
        config = function()
            require("CopilotChat").setup({
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
        end
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
            "svelte",
            "xml"
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    rust = { "rustfmt", lsp_format = "fallback" },
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { "prettierd", "prettier", stop_after_first = true },
                    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                    json = { "prettierd", "prettier", stop_after_first = true },
                    postgresql = { "prettierd", "prettier", stop_after_first = true },
                    sql = { "prettierd", "prettier", stop_after_first = true },
                    css = { "prettierd", "prettier", stop_after_first = true },
                    html = { "prettierd", "prettier", stop_after_first = true },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight-night",
                },
            })
        end
    },
    {
        "folke/which-key.nvim",
        opts = {},
        config = function()
            require("which-key").setup({
                plugins = {
                    spelling = { enabled = true },
                },
            })
        end
    },
}

require("lazy").setup({
    spec = {
        plugins,
        -- { import = plugins },
    },
    install = { colorscheme = { "tokyonight-night" } },
    checker = { enabled = true },
})

local function get_filename()
    local project_dir = vim.fn.expand('%:p:h')
    if project_dir == "/" then
        project_dir = "_"
    elseif project_dir == "" then
        project_dir = "unknown"
    end
    local filename = string.gsub(project_dir, "/", "_")
    if filename == "" or "/" then
        filename = "_"
    end
    return filename
end
local function save_convo()
    local filename = get_filename()
    if vim.bo.filetype == "copilot-chat" then
        vim.cmd("CopilotChatSave " .. filename)
    end
end
vim.api.nvim_create_autocmd(
    { 'ModeChanged' },
    { pattern = { "i:*", "*:n" }, callback = save_convo }
)
vim.api.nvim_create_autocmd(
    {
        'QuitPre', 'ExitPre', 'VimLeavePre',
        'WinClosed', 'TabClosed', 'BufDelete',
        'SourcePre', 'BufWritePost'
    },
    { callback = save_convo }
)

vim.lsp.enable(SERVERS)

vim.keymap.set("n", "<C-v>", "<C-v>", { noremap = true, remap = false })
-- oil
vim.keymap.set("n", "<leader>e", ":Oil<CR>")
-- lsp
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)
-- copilot chat
vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>")
vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>")
vim.keymap.set("v", "<leader>co", ":CopilotChatOptimize<CR>")
vim.keymap.set("v", "<leader>cf", ":CopilotChatFix<CR>")
vim.keymap.set("n", "<leader>cs", ":CopilotChatSave ")
vim.keymap.set("n", "<leader>cl", ":CopilotChatLoad ")
