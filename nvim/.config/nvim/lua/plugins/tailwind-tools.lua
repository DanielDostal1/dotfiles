-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	-- build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
		"neovim/nvim-lspconfig", -- optional
	},
	config = function()
		require("tailwind-tools").setup {
			--[[ vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.html", "*.tsx", "*.jsx", "*.vue", "*.svelte" },
				callback = function() require("tailwind-tools.format").sort() end,
			}), ]]
		}
	end,
}
