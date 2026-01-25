return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load immediately to paint UI
		priority = 1000, -- Load before all other plugins
		config = function()
			require("tokyonight").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"MunifTanjim/nui.nvim",
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		presets = {
	-- 			bottom_search = true, -- use a classic bottom cmdline for search
	-- 			-- command_palette = true, -- position the cmdline and popupmenu together
	-- 			long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 		},
	-- 		lsp = {
	-- 			progress = {
	-- 				enabled = false,
	-- 			},
	-- 		},
	-- 		notify = {
	-- 			enabled = false,
	-- 		},
	-- 		messages = {
	-- 			enabled = false,
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	{
		-- Hints keybinds
		"folke/which-key.nvim",
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"folke/twilight.nvim",
		keys = {
			{ "<leader>tt", "<CMD>:Twilight<CR>", desc = "Toggle twilight" },
		},
		opts = {
			dimming = {
				alpha = 0.25, -- amount of dimming
				-- we try to get the foreground from the highlight groups or fallback color
				color = { "Normal", "#ffffff" },
				term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
				inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 10, -- amount of lines we will try to show around the current line
			treesitter = true, -- use treesitter when available for the filetype
			-- treesitter is used to automatically expand the visible text,
			-- but you can further control the types of nodes that should always be fully expanded
			expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
				"table",
				"if_statement",
			},
			exclude = {}, -- exclude these filetypes
		},
	},
}
