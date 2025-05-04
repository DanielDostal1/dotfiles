return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local mark = require "harpoon.mark"
		local ui = require "harpoon.ui"

		require("harpoon").setup {
			menu = {
				width = 80,
			},
		}

		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-h>", ui.toggle_quick_menu)

		vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end, { desc = "Navigate to file 1" })
		vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end, { desc = "Navigate to file 2" })
		vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end, { desc = "Navigate to file 3" })
		vim.keymap.set("n", "<C-m>", function() ui.nav_file(4) end, { desc = "Navigate to file 4" })
	end,
}
