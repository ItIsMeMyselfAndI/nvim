return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',
	opts = {
		keymap = { preset = 'default' },
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" },
	config = function()
		require('blink.cmp').setup({
			keymap = { preset = 'default' },
			completion = { documentation = { auto_show = true } },
			fuzzy = { implementation = "lua" },
			signature = { enabled = true },
		})

		for _, server in pairs(SERVERS) do
			vim.lsp.config(server, {
				capabilities = require('blink.cmp').get_lsp_capabilities()
			})
		end
	end
}
