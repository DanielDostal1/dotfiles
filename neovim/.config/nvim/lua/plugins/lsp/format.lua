return {
	{
		"stevearc/conform.nvim",
		config = function()
			-- Formatters installed with Mason, binaries added to $PATH on neovim start
			local formatters_with_ft = require("plugins.lsp.packages").formatters_with_ft
			local utils = require("core.utils")

			require("conform").setup({
				formatters_by_ft = utils.packages_by_ft_with_commands(formatters_with_ft),
			})
		end,
		keys = {
			{ "<leader>f", "<Cmd>lua require('conform').format()<CR>", desc = "Conform format" },
		},
	},
}
