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
            jsonls = {},
            tailwindcss = {},
            cssls = {},
            html = {},
            markdown_oxide = {},
            -- pylsp = {},
            pyright = {
                settings = {
                    python = {
                        diagnostics = {
                            typeCheckingMode = "true",
                        },
                        analysis = {
                            typeCheckingMode = "true",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                        workspace = {
                            checkThirdParty = true,
                        },
                    },
                },
            },
            zk = {},
            eslint = {},
        },
    },
    config = function(_, opts)
        require("mason").setup()
        for server, config in pairs(opts.servers) do
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            config.on_attach = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end
            -- require('lspconfig')[server].setup(config)
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
        require("mason-lspconfig").setup({
            ensure_installed = SERVERS,
            automatic_installation = true,
        })
    end
}
