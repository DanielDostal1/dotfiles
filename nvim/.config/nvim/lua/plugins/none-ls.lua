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

		-- Mason integration: ensure tools are installed
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
			},
			automatic_installation = true,
		}

		-- Null-ls sources (formatters/linters)
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
		}

		-- Go LSP (gopls)
		require("lspconfig").gopls.setup {
			settings = {
				gopls = {
					usePlaceholders = false,
					completeUnimported = true,
				},
			},
		}

		-- SQL LSP (sqls)
		require("lspconfig").sqls.setup {}

		-- Null-ls setup
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
