return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "]h", gs.next_hunk, "Next Hunk")
			map("n", "[h", gs.prev_hunk, "Prev Hunk")

			-- Stage/Reset operations
			map("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
			map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
			map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
			map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage Selected Hunks")
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset Selected Hunks")

			-- Preview and diff
			map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
			map("n", "<leader>gd", gs.diffthis, "Diff This")
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, "Diff Against Last Commit")
			map("n", "<leader>gtd", gs.toggle_deleted, "Toggle Deleted")
			map("n", "<leader>gR", gs.refresh, "Refresh Gitsigns")

			-- Blame operations
			map("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end, "Blame Line")
			map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle Line Blame")

			-- Text objects
			map({ "o", "x", "n" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
		end,
	},
}
