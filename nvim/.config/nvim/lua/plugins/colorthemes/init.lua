local M = {}
-- Function to load the current theme from the file
local function load_current_theme()
	local file = io.open(vim.fn.stdpath "config" .. "/lua/plugins/colorthemes/current_theme.txt", "r")
	if not file then
		print "Could not find file current_theme.txt in /lua/plugins/colorthemes/"
		return nil -- Return nil if the file doesn't exist
	end
	local current_theme = file:read "*all"
	file:close()
	return current_theme:match "^%s*(.-)%s*$" -- Trim any whitespace
end

-- Function to save the current theme to the file
local function save_current_theme(theme)
	local file = io.open(vim.fn.stdpath "config" .. "/lua/plugins/colorthemes/current_theme.txt", "w")
	if not file then
		return
	end
	file:write(theme)
	file:close()
end

-- Theme plugin definitions
M.plugins = {
	require "plugins.colorthemes.rose-pine",
	require "plugins.colorthemes.onedark",
	require "plugins.colorthemes.nightfox",
	require "plugins.colorthemes.catppuccin",
}

-- Theme toggling logic
M.setup = function()
	-- Load the saved theme at startup, if available
	local current_theme = load_current_theme()
	if current_theme then
		vim.cmd("colorscheme " .. current_theme)
	else
		vim.cmd "colorscheme nightfox"
	end

	-- Keymap for toggling themes
	vim.keymap.set("n", "<leader>tt", function()
		local themes = { "rose-pine", "onedark", "nightfox", "catppuccin" }
		local current = vim.g.colors_name
		local next = themes[((vim.fn.index(themes, current) or 0) + 1) % #themes + 1]

		print("Themes available: ", vim.inspect(themes))
		print("Current theme: ", current_theme)

		-- Set the next theme
		vim.cmd("colorscheme " .. next)

		-- Save the new theme to the file
		save_current_theme(next)

		-- Print the theme change message
		print("Switched to colorscheme: " .. next)
	end, { desc = "Toggle Themes" })
end

return M
