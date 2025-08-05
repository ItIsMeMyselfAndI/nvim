require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
    file_types = { "markdown", "copilot-chat", "nvim-pack://6/confirm-update" },
})

