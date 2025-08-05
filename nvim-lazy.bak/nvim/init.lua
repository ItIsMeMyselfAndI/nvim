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

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
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
			vim.cmd[[colorscheme tokyonight-night]]
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
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup({
                ensure_intalled = SERVERS
            })
        end
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },
            completion = { documentation = { auto_show = true } },
            sources = {
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            for _, server in pairs(SERVERS) do
                require('lspconfig')[server].setup({
                    capabilities = require('blink.cmp').get_lsp_capabilities()
                })
            end
            require("lspconfig").lua_ls.setup({
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
            })
        end
    } ,
}

require("lazy").setup({
    spec = {
        plugins
		-- { import = plugins },
	},
	install = { colorscheme = { "tokyonight-night" } },
	checker = { enabled = true },
})

vim.lsp.enable(SERVERS)
