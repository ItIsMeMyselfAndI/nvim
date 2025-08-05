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

