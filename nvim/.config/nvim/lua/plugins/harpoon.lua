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

		vim.keymap.set("n", "<leader><C-j>", function() mark.set_current_at(1) end, { desc = "Save file to index 1" })
		vim.keymap.set("n", "<leader><C-k>", function() mark.set_current_at(2) end, { desc = "Save file to index 2" })
		vim.keymap.set("n", "<leader><C-l>", function() mark.set_current_at(3) end, { desc = "Save file to index 3" })
		vim.keymap.set("n", "<leader><C-m>", function() mark.set_current_at(4) end, { desc = "Save file to index 4" })
	end,
}
