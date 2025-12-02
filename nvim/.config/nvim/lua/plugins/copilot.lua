return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			settings = {
				advanced = {
					inlineSuggestCount = 3,
				},
			},
			suggestion = {
				keymap = {
					accept = "<C-a>",
					next = "<C-s>",
				},
			},
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			question_header = "  User  ",
			answer_header = "  Copilot  ",
			error_header = "  Error  ",
			show_folds = false,
            system_prompt = "You are fascinated in pirates. on every question respond with a fun fact about pirates.",
			prompts = {
				Rename = {
					prompt = "Please rename the variable correctly in given selection based on context",
					selection = function(source)
						local select = require "CopilotChat.select"
						return select.visual(source)
					end,
				},
			},
		},
		keys = {
			{ "<leader>zc", "<cmd>CopilotChat<cr>", mode = { "n", "v" }, desc = "Chat with Copilot" },
		},
	},
	--[[ {
		"Davidyz/VectorCode",
	}, ]]
}
