return {
	{
		-- Autoclose parentheses, brackets, quotes, etc...
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Autoclose tags
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
}
