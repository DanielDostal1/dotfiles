return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local mode = {
			"mode",
			fmt = function(str)
				return "🐌 "
			end,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 1,
			color = { fg = "#ebdbb2" }, -- Gruvbox light beige
		}

		local hide_in_width = function() return vim.fn.winwidth(0) > 100 end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
			colored = false,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = { added = "+", modified = "~", removed = "-" },
			cond = hide_in_width,
		}

		-- Custom Gruvbox Dark theme
		local gruvbox_dark = {
			normal = {
				a = { fg = '#282828', bg = '#d65d0e', gui = 'bold' }, -- Orange accent
				b = { fg = '#a89984', bg = '#3c3836' }, -- Gray
				c = { fg = '#ebdbb2', bg = '#282828' }  -- Default background
			},
			insert = {
				a = { fg = '#282828', bg = '#98971a', gui = 'bold' }, -- Green
				b = { fg = '#a89984', bg = '#3c3836' },
				c = { fg = '#ebdbb2', bg = '#282828' }
			},
			visual = {
				a = { fg = '#282828', bg = '#b16286', gui = 'bold' }, -- Magenta
				b = { fg = '#a89984', bg = '#3c3836' },
				c = { fg = '#ebdbb2', bg = '#282828' }
			},
			replace = {
				a = { fg = '#282828', bg = '#fb4934', gui = 'bold' }, -- Red
				b = { fg = '#a89984', bg = '#3c3836' },
				c = { fg = '#ebdbb2', bg = '#282828' }
			},
			command = {
				a = { fg = '#282828', bg = '#d79921', gui = 'bold' }, -- Yellow
				b = { fg = '#a89984', bg = '#3c3836' },
				c = { fg = '#ebdbb2', bg = '#282828' }
			},
			inactive = {
				a = { fg = '#665c54', bg = '#3c3836' },
				b = { fg = '#665c54', bg = '#3c3836' },
				c = { fg = '#665c54', bg = '#282828' }
			}
		}

		require("lualine").setup {
			options = {
				icons_enabled = true,
				theme = gruvbox_dark,
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { 
					{ 
						"branch", 
						icon = "", 
						color = { fg = "#a89984" } 
					} 
				},
				lualine_c = { filename },
				lualine_x = {
					diagnostics,
					diff,
					{ 
						"filetype", 
						icons_enabled = false,
						cond = hide_in_width,
						color = { fg = "#a89984" }
					},
				},
				lualine_y = { 
					{ 
						"location", 
						color = { fg = "#a89984" } 
					} 
				},
				lualine_z = { 
					{ 
						"progress", 
						color = { fg = "#a89984" } 
					} 
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1, color = { fg = "#665c54" } } },
				lualine_x = { { "location", padding = 0, color = { fg = "#665c54" } } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		}
	end,
}
