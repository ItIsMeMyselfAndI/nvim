return {
    "mason-org/mason.nvim",
    dependencies = {
        { 'mason-org/mason-lspconfig.nvim' },
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
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = SERVERS,
        })
        for server, config in pairs(opts.servers) do
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            config.on_attach = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end
            require('lspconfig')[server].setup(config)
        end
    end
}
