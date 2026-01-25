local M = {}

-- ':h lspconfig-setup'
M.lsp_configurations = {
	-- 	lua_ls = {
	-- 		settings = {
	-- 			Lua = {
	-- 				completion = { callSnippet = "Replace" },
	-- 				runtime = { version = "LuaJIT" },
	-- 				workspace = {
	-- 					checkThirdParty = false,
	-- 					library = {
	-- 						"${3rd}/luv/library",
	-- 						unpack(vim.api.nvim_get_runtime_file("", true)),
	-- 					},
	-- 				},
	-- 				diagnostics = { disable = { "missing-fields", "vim" }, globals = { "vim" } },
	-- 				format = { enable = false },
	-- 			},
	-- 		},
	-- 	},
}

return M
