return {
	{
		"everviolet/nvim",
		name = "evergarden",
		priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
		opts = {
			theme = {
				variant = "fall", -- 'winter'|'fall'|'spring'|'summer'
				accent = "green",
			},
			editor = {
				transparent_background = true,
				sign = { color = "none" },
				float = {
					color = "mantle",
					solid_border = false,
				},
				completion = {
					color = "surface0",
				},
			},
		},
		-- config = function()
		-- 	vim.cmd.colorscheme("evergarden")
		-- end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			-- require("gruvbox").setup({
			-- 	transparent_mode = true,
			-- 	contrast = "hard", -- can be "hard", "soft" or empty string
			-- })
		end,
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load immediately to paint UI
		priority = 1000, -- Load before all other plugins
		-- config = function()
		-- 	require("tokyonight").setup({
		-- 		transparent = true,
		-- 	})
		-- 	vim.cmd.colorscheme("tokyonight")
		-- end,
	},
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
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
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			}, {
				css = true,
			})
		end,
	},
	{
		-- Highlight hex colors

		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({
				options = { parsers = { css = true } },
			})
		end,
	},
}
