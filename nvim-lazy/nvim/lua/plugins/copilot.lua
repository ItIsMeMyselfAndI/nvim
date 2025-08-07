return {
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
                width = 0.5,
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
}
