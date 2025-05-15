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
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			question_header = "  User  ",
			answer_header = "  Copilot  ",
			error_header = "  Error  ",
			show_folds = false,
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
			{ "<leader>ze", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "Explain Code" },
			{ "<leader>zr", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Review Code" },
			{ "<leader>zf", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "Fix Code Issues" },
			{ "<leader>zo", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "Optimize Code" },
			{ "<leader>zd", "<cmd>CopilotChatDocs<cr>", mode = { "n", "v" }, desc = "Generate Docs" },
			{ "<leader>zn", "<cmd>CopilotChatRename<cr>", mode = { "v" }, desc = "Rename the variable" },
		},
	},
}
