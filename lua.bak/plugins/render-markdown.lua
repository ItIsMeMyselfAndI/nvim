return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you use the mini.nvim suite
	opts = {},
	config = function()
		require('render-markdown').setup({
			completions = { lsp = { enabled = true } },
			file_types = { "markdown", "copilot-chat", "nvim-pack://6/confirm-update" },
		})

	end
}
