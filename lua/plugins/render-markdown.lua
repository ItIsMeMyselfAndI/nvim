return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } },
            file_types = { "markdown", "copilot-chat", },
        })
    end
}
