return {
	{
		"stevearc/oil.nvim",
        lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
		config = function()
			require("oil").setup {
				default_file_explorer = true,
				delete_to_trash = true,
				view_options = { show_hidden = true },
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-h>"] = false, -- Harpoon remap
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = { "actions.close", mode = "n" },
					-- ["<C-l>"] = "actions.refresh",
					["<C-l>"] = false, -- Harpoon remap
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["gt"] = { "actions.toggle_trash", mode = "n" },
					["g\\"] = false, -- no need for trash to be there 2 times
				},
			}

            -- Automatically open Oil if nvim is started without arguments
            if vim.fn.argc() == 0 then
                require("oil").open(".")
            end
		end,
	},
}
