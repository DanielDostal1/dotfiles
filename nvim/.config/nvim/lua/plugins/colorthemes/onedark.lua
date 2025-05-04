return {
	{
		"navarasu/onedark.nvim",
		name = "onedark",
		config = function()
			require("onedark").setup {
				style = "dark",
				transparent = true,
				term_colors = true,
			}
		end,
	},
}
