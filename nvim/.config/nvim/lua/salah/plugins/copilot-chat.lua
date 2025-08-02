return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	cmd = "CopilotChat",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = function()
		local user = vim.env.USER or "User"
		user = user:sub(1, 1):upper() .. user:sub(2)
		return {
			model = "claude-sonnet-4",
			auto_insert_mode = true,
			question_header = "  " .. user .. " ",
			answer_header = "  Copilot ",
			window = {
				width = 0.4,
			},
			mappings = {
				reset = "",
			},
		}
	end,
	keys = {
		{ "<leader>c", "", desc = "+copilot", mode = { "n", "v" } },
		{
			"<leader>cc",
			function()
				return require("CopilotChat").toggle()
			end,
			desc = "Toggle (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>cr",
			function()
				return require("CopilotChat").reset()
			end,
			desc = "Clear (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>cq",
			function()
				vim.ui.input({
					prompt = "Quick Chat: ",
				}, function(input)
					if input ~= "" then
						require("CopilotChat").ask(input)
					end
				end)
			end,
			desc = "Quick Chat (CopilotChat)",
			mode = { "n", "v" },
		},
		{
			"<leader>cp",
			function()
				require("CopilotChat").select_prompt()
			end,
			desc = "Prompt Actions (CopilotChat)",
			mode = { "n", "v" },
		},
	},
	config = function(_, opts)
		local chat = require("CopilotChat")

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "copilot-chat",
			callback = function()
				vim.opt_local.relativenumber = false
				vim.opt_local.number = false
			end,
		})

		chat.setup(opts)
	end,
}
