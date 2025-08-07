return {
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
}
