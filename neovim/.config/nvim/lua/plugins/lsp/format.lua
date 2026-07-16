return {
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		config = function()
			-- Formatters installed with Mason, binaries added to $PATH on neovim start
			local formatters_with_ft = require("plugins.lsp.packages").formatters_with_ft
			local utils = require("core.utils")

			require("conform").setup({
				formatters_by_ft = utils.packages_by_ft_with_commands(formatters_with_ft),
			})
		end,
		keys = {
			{
				"<leader>f",
				function()
					local conform = require("conform")
					if #conform.list_formatters_for_buffer() > 0 then
						conform.format({ lsp_format = "never" })
					else
						vim.lsp.buf.format()
					end
				end,
				desc = "Format buffer",
			},
		},
	},
}
