return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		-- See Configuration section for options
	},
	config = function()
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

	end
}

