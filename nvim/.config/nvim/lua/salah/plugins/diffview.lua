local update_left_pane = function()
	pcall(function()
		local lib = require("diffview.lib")
		local view = lib.get_current_view()
		if view then
			-- This updates the left panel with all the files, but doesn't update the buffers
			view:update_files()
		end
	end)
end

vim.api.nvim_create_autocmd("FocusGained", {
	callback = update_left_pane,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "DiffviewViewLeave",
	callback = function()
		vim.cmd(":DiffviewClose")
	end,
})

return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
			default_args = {
				DiffviewOpen = { "--imply-local" },
			},
			view = {
				default = {
					winbar_info = true,
					disable_diagnostics = true,
				},
				merge_tool = {
					winbar_info = true,
					disable_diagnostics = true,
				},
				file_history = {
					winbar_info = true,
					disable_diagnostics = true,
				},
			},
			keymaps = {
				view = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
				file_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
				file_history_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
			},
		})

		vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [D]iff" })
		vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "[G]it File [H]istory" })
		vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "[G]it Repo [H]istory" })
	end,
}
