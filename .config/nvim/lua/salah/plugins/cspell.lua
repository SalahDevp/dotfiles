return {
	"davidmh/cspell.nvim",
	dependencies = {
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local cspell = require("cspell")
		require("null-ls").setup({
			sources = {
				cspell.diagnostics.with({
					-- Force the severity to be HINT
					diagnostics_postprocess = function(diagnostic)
						diagnostic.severity = vim.diagnostic.severity.HINT
					end,
				}),
				cspell.code_actions,
			},
		})
	end,
}
