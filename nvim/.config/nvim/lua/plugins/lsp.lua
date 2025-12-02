return {
	-- Lua development LSP (for Neovim runtime & plugins)
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

	-- Main LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Keymaps for LSP actions
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- Document highlights
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = group,
							callback = vim.lsp.buf.clear_references,
						})
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
							end,
						})
					end

					-- Toggle inlay hints
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map(
							"<leader>th",
							function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
							end,
							"[T]oggle Inlay [H]ints"
						)
					end
				end,
			})

			vim.api.nvim_create_autocmd({ "VimEnter", "VimResized" }, {
				desc = "Setup LSP hover window",
				callback = function()
					local width = math.floor(vim.o.columns * 0.8)
					local height = math.floor(vim.o.lines * 0.3)

					vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
						border = "rounded",
						max_width = width,
						max_height = height,
					})
				end,
			})

			-- Capabilities (completion, etc.)
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- Language servers
			local servers = {
				html = { filetypes = { "html", "twig", "hbs" } },
				cssls = {},
				sqlls = {},
				jsonls = {},
				--[[ gopls = {
					settings = {
						gopls = {
							usePlaceholders = false,
							completeUnimported = true,
						},
					},
				}, ]]
				hls = {
					cmd = { "haskell-language-server-wrapper", "--lsp" },
					filetypes = { "haskell", "lhaskell", "cabal" },
					root_dir = require("lspconfig.util").root_pattern(
						"hie.yaml",
						"stack.yaml",
						"cabal.project",
						"package.yaml",
						".git"
					),
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							diagnostics = { disable = { "missing-fields", "vim" }, globals = { "vim" } },
							format = { enable = false },
						},
					},
				},
			}

			-- Mason setup
			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup { ensure_installed = ensure_installed }
			require("mason").setup {
				registries = {
					"github:Crashdummyy/mason-registry", -- this contains the register for Roslyn
					"github:mason-org/mason-registry",
				},
				ensure_installed = {
					"roslyn",
					"rzls",
				},
			}

			-- Mason-lspconfig setup
			require("mason-lspconfig").setup {
				handlers = {
					-- Default setup for all servers
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						--[[ vim.lsp.config(server_name, server)
						vim.lsp.enable(server_name) ]]
                        require("lspconfig")[server_name].setup(server)
					end,
				},
			}
		end,
	},
	{
		"seblyng/roslyn.nvim",
		enabled = true,
		ft = "cs",
		config = function()
			vim.lsp.config("roslyn", {
				on_attach = function() print "This will run when the server attaches!" end,
				settings = {
					-- Check settings in https://github.com/seblyng/roslyn.nvim
				},
			})
			local roslyn = require "roslyn"
			roslyn.setup()
		end,
	},
}
