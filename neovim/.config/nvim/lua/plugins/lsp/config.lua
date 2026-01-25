return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local packages = require("plugins.lsp.packages")
			local lsp_configurations = require("plugins.lsp.configurations").lsp_configurations
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local map = require("core.utils").map

			mason_lspconfig.setup()

			for _, server in ipairs(packages.lsp) do
				if not vim.tbl_contains(packages.managed_separately or {}, server) then
					local config = lsp_configurations[server] or {}
					config.capabilities = capabilities

					config.on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false

						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("n", "<leader>th", function()
								vim.lsp.inlay_hint.enable(
									not vim.lsp.inlay_hint.is_enabled({ bufnr = vim.api.nvim_get_current_buf() })
								)
							end, "[T]oggle Inlay [H]ints")
						end
					end

					if vim.lsp.config[server] then
						vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server], config)
					else
						vim.lsp.config[server] = config
					end

					vim.lsp.enable(server)
				end
			end

			-- Diagnostics UI
			vim.diagnostic.config({
				signs = false,
				virtual_text = true,
				severity_sort = true,
				float = { border = border, source = true, header = "" },
			})

			-- Keymaps
			map("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<cr>')
			map("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<cr>')
			map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
			map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
			map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
			map("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<cr>")
			map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
			-- map("n", "K", function()
			--     vim.lsp.buf.hover({ border = "rounded" })
			-- end)
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
}
