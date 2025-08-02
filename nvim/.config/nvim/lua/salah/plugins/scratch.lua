return {
	"SalahDevp/scratch.nvim",
	dev = false,
	config = function()
		local scratch = require("scratch")

		scratch.setup({
			languages = {
				lua = {
					run_cmd = "lua",
				},
				python = {
					run_cmd = "python3",
				},
				c = {
					run_cmd = "gcc -x c - -o /dev/stdout | sh",
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>bs", "<cmd>Scratch buf<cr>")
		vim.keymap.set("n", "<leader>be", "<cmd>Scratch eval<cr>")
	end,
}
