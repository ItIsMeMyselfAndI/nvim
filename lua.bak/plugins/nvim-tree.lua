return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{"<leader>E", ":NvimTreeToggle<CR>"}
	},
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
	end,
}
