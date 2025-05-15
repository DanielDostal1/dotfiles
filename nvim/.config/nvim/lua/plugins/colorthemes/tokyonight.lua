return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		config = function()
			require("tokyonight").setup {
				transparent = true,
			}
		end,
	},
}
