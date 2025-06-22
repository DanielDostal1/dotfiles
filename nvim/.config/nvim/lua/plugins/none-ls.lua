return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require "null-ls"
		local eslint_d = require "none-ls.diagnostics.eslint_d"

		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup {
			ensure_installed = {
				"prettier", -- ts/js formatter
				"eslint-lsp", -- ts/js linter
				"stylua", -- lua formatter
				"shfmt", -- Shell formatter
				"gofmt", -- Go formatter
				"gopls", -- Go language server
				"sqls", -- SQL language server
				-- "ruff", -- Python linter and formatter
			},
			automatic_installation = true,
		}

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
			formatting.gofmt.with {
				filetypes = { "go" },
			},
			formatting.stylua,
			formatting.shfmt.with { args = { "-i", "4" } },
			eslint_d.with {
				filetypes = { "javascript", "typescript", "typescriptreact" },
			},
		}

		-- Set up LSP config for gopls (Go language server)
		require("lspconfig").gopls.setup {
			on_attach = function(client, bufnr)
				-- Enable formatting with gopls
				--[[ if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_clear_autocmds { group = "LspFormatting", buffer = bufnr }
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = "LspFormatting",
						buffer = bufnr,
						callback = function() vim.lsp.buf.format { async = false } end,
					})
				end ]]
			end,
			settings = {
				gopls = {
					usePlaceholders = false,
					completeUnimported = true,
				},
			},
		}

		require("lspconfig").sqls.setup {
			on_attach = function(client, bufnr)
				-- You can set up keymaps for running queries here if desired
				-- Example:
				-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sq", "<cmd>SqlsExecuteQuery<CR>", { noremap = true, silent = true })
			end,
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup {
			-- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
			sources = sources,
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				--[[ if client.supports_method "textDocument/formatting" then
					vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function() vim.lsp.buf.format { async = false } end,
					})
				end ]]
			end,
		}
		vim.keymap.set(
			"n",
			"<leader>f",
			function() vim.lsp.buf.format { async = true } end,
			{ desc = "Format file manually" }
		)
	end,
}
