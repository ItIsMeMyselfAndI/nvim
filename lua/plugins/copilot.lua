return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
        { "github/copilot.vim" },
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
        vim.g.copilot_no_tab_map = true
        vim.keymap.set('i',
            '<S-Tab>',
            'copilot#Accept("\\<S-Tab>")',
            {
                expr = true,
                replace_keycodes = false
            }
        )
    end
}
