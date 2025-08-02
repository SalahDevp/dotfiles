return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():select(1)
		end, { desc = "harpoon 1" })
		vim.keymap.set("n", "<leader>hs", function()
			harpoon:list():select(2)
		end, { desc = "harpoon 2" })
		vim.keymap.set("n", "<leader>hd", function()
			harpoon:list():select(3)
		end, { desc = "harpoon 3" })
		vim.keymap.set("n", "<leader>hf", function()
			harpoon:list():select(4)
		end, { desc = "harpoon 4" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "harpoon previous" })
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "harpoon next" })
	end,
}
