return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", function()
				vim.cmd ":UndotreeToggle"
				-- Move the cursor to the leftmost window (the undo tree window)
				vim.defer_fn(function()
					while vim.fn.win_screenpos(vim.fn.winnr())[2] ~= 1 do
						vim.cmd "wincmd h"
					end
				end, 10)
			end, { noremap = true, silent = true })
		end,
	},
}
