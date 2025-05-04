return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup {
				variant = "main",
				dark_variant = "main",
				enable = {
					terminal = true,
				},
				styles = {
					transparency = true,
				},
			}
		end,
	},
}
