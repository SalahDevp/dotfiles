local function get_buffer_absolute()
	return vim.fn.expand("%:p")
end

local function get_buffer_cwd_relative()
	return vim.fn.expand("%:.")
end

local function get_visual_bounds()
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		error(
			"get_visual_bounds must be called in visual or visual-line mode (current mode: " .. vim.inspect(mode) .. ")"
		)
	end
	local is_visual_line_mode = mode == "V"
	local start_pos = vim.fn.getpos("v")
	local end_pos = vim.fn.getpos(".")

	return {
		start_line = math.min(start_pos[2], end_pos[2]),
		end_line = math.max(start_pos[2], end_pos[2]),
		start_col = is_visual_line_mode and 0 or math.min(start_pos[3], end_pos[3]) - 1,
		end_col = is_visual_line_mode and -1 or math.max(start_pos[3], end_pos[3]),
		mode = mode,
		start_pos = start_pos,
		end_pos = end_pos,
	}
end

local function format_line_range(start_line, end_line)
	return start_line == end_line and tostring(start_line) or start_line .. "-" .. end_line
end

local function simulate_yank_highlight()
	local bounds = get_visual_bounds()

	local ns = vim.api.nvim_create_namespace("simulate_yank_highlight")
	vim.highlight.range(
		0,
		ns,
		"IncSearch",
		{ bounds.start_line - 1, bounds.start_col },
		{ bounds.end_line - 1, bounds.end_col },
		{ priority = 200 }
	)
	vim.defer_fn(function()
		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
	end, 150)
end

local function exit_visual_mode()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

local function yank_path(path, label)
	vim.fn.setreg("+", path)
	print("Yanked " .. label .. " path: " .. path)
end

local function yank_visual_with_path(path, label)
	local bounds = get_visual_bounds()

	local selected_lines = vim.fn.getregion(bounds.start_pos, bounds.end_pos, { type = bounds.mode })
	local selected_text = table.concat(selected_lines, "\n")

	local line_range = format_line_range(bounds.start_line, bounds.end_line)
	local path_with_lines = path .. ":" .. line_range

	local result = path_with_lines .. "\n\n" .. selected_text
	vim.fn.setreg("+", result)

	simulate_yank_highlight()

	exit_visual_mode()

	print("Yanked " .. label .. " with lines " .. line_range)
end

vim.keymap.set("n", "<leader>ya", function()
	yank_path(get_buffer_absolute(), "absolute")
end, { desc = "[Y]ank [A]bsolute path to clipboard" })

vim.keymap.set("n", "<leader>yr", function()
	yank_path(get_buffer_cwd_relative(), "relative")
end, { desc = "[Y]ank [R]elative path to clipboard" })

vim.keymap.set("v", "<leader>ya", function()
	yank_visual_with_path(get_buffer_absolute(), "absolute")
end, { desc = "[Y]ank selection with [A]bsolute path" })

vim.keymap.set("v", "<leader>yr", function()
	yank_visual_with_path(get_buffer_cwd_relative(), "relative")
end, { desc = "[Y]ank selection with [R]elative path" })

-- Credit: richardgill on github
