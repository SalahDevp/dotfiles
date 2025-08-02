return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	enabled = false,
	version = "*",
	after = "catppuccin",
	config = function()
		require("bufferline").setup({
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
		})
	end,
	opts = {
		options = {
			mode = "tabs",
			separator_style = "slant",
		},
	},
}
