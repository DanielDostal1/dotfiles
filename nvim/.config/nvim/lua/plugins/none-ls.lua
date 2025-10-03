return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require "null-ls"
		local formatting = null_ls.builtins.formatting
		-- local diagnostics = null_ls.builtins.diagnostics

		-- Mason-Null-LS integration
		require("mason-null-ls").setup {
			ensure_installed = {
				"prettier",
				"eslint-lsp",
				"stylua",
				"shfmt",
				"gofmt",
				"gopls",
				"sqls",
				"ruff",
				"csharpier",
			},
			automatic_installation = true,
		}

		-- Null-LS sources (formatters/linters)
		local sources = {
			formatting.prettier.with {
				filetypes = {
					"html",
					"json",
					"markdown",
					"javascript",
					"typescript",
					"typescriptreact",
					"css",
					"scss",
					"go",
					"yaml",
					"yml",
				},
			},
			formatting.gofmt.with { filetypes = { "go" } },
			formatting.stylua,
			formatting.shfmt.with { args = { "-i", "4" } },
      formatting.csharpier.with { filetypes = { "cs" } }
		}

		-- Null-LS setup
		null_ls.setup {
			sources = sources,
			on_attach = function(client, bufnr)
				-- Optional: autoformatting on save (currently disabled)
			end,
		}

		-- Manual format keymap
		vim.keymap.set(
			"n",
			"<leader>f",
			function() vim.lsp.buf.format { async = true } end,
			{ desc = "Format file manually" }
		)
	end,
}
