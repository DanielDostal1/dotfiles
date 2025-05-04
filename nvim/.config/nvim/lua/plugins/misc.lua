return {
	{
		-- Hints keybinds
		"folke/which-key.nvim",
	},
	{
		{
			-- Autoclose parentheses, brackets, quotes, etc...
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			opts = {},
		},
	},
	{
		{
			-- Autoclose tags
			"windwp/nvim-ts-autotag",
			event = "InsertEnter",
			config = true,
			opts = {},
		},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"b3nj5m1n/kommentary",
		config = function()
			require("kommentary.config").configure_language("default", {
				single_line_comment_string = "auto",
				multi_line_comment_strings = "auto",
				hook_function = function() require("ts_context_commentstring").update_commentstring() end,
			})
		end,
	},
	{
		-- Highlight hex colors
		"norcalli/nvim-colorizer.lua",
		config = function() require("colorizer").setup() end,
	},
}
