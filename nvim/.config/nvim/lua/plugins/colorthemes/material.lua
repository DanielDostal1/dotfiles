return {
	{
		"marko-cerovac/material.nvim",
		name = "material",
		config = function()
			require("material").setup {
				--[[ transparent_background = true,
				term_colors = true, ]]
			}
		end,
	},
}
