return {
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		config = function()
			require("nightfox").setup {
				options = {
					transparent = true,
					terminal_colors = true,
					styles = {
						comments = "italic",
					},
				},
			}
			-- You can set the colorscheme here or leave it for `init.lua` to decide
			-- vim.cmd "colorscheme nightfox"
		end,
	},
}
