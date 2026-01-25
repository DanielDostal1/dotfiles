return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			settings = {
				publish_diagnostic_on = "change",
				expose_as_code_action = {
					"add_missing_imports",
					"remove_unused_imports",
					"organize_imports",
				},
				tsserver_plugins = {},
			},
		},
	},
	{
		"seblyng/roslyn.nvim",
		enabled = true,
		ft = "cs",
		config = function()
			vim.lsp.config("roslyn", {
				on_attach = function() print "This will run when the server attaches!" end,
				settings = {
					-- Check settings in https://github.com/seblyng/roslyn.nvim
				},
			})
			local roslyn = require "roslyn"
			roslyn.setup()
		end,
	},
}
