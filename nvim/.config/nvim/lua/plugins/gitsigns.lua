-- Adds git related signs to the gutter, as well as utilities for managing changes
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
		event = "VeryLazy",
		-- Because of the keys part, you will be lazy loading this plugin.
		-- The plugin wil only load once one of the keys is used.
		-- If you want to load the plugin at startup, add something like event = "VeryLazy",
		-- or lazy = false. One of both options will work.
		opts = {
			-- your configuration comes here
			-- for example
			enabled = true, -- if you want to enable the plugin
			message_template = " <author> • <summary> • <date> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M", -- template for the date, check Date format section for more options
			-- date_format = "%m-%d-%Y %H:%M:%S",
			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
    --[[ keys = {
      {
        "<leader>gb",
        function()
          local sha = require("gitblame").get_current_blame_text()
          if sha then
            local commit = sha:match("([a-f0-9]+)")
            if commit then
              vim.fn.setreg("+", commit)
              vim.notify("Commit SHA copied to clipboard: " .. commit)
            else
              vim.notify("No commit SHA found under cursor", vim.log.levels.WARN)
            end
          else
            vim.notify("No blame info available", vim.log.levels.WARN)
          end
          vim.cmd("LazyGit")
        end,
        desc = "Copy commit SHA and open LazyGit"
      }
    }, ]]
	},
}
