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
				-- complete_function_calls = true,
				-- include_completions_with_insert_text = true,
			},
		},
	},
}
