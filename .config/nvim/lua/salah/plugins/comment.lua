return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			-- for commenting tsx and jsx files
			pre_hook = ts_context_commentstring.create_pre_hook(),

			-- add a space between comment and the line
			padding = true,

			-- whether to stay on the line after commenting
			sticky = true,

			-- lines to be ignored while (un)comment
			ignore = "^$",

			-- keybindings for normal mode
			toggler = {
				line = "gcc",
				block = "gbc",
			},

			-- keybindings for operator-pending mode
			opleader = {
				line = "gc",
				block = "gb",
			},

			-- extra mappings
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},

			-- function to be called after (un)comment
			post_hook = nil,
		})
	end,
}
