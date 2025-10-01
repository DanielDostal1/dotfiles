return {
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
