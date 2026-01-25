return {
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signs_staged_enable = false,
		},
	},
	{
		"f-person/git-blame.nvim",
		lazy = true,
		opts = {
			message_template = " <author> • <summary> • <date> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M",
			virtual_text_column = 1,
		},
	},
}
