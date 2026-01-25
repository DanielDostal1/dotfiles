local M = {}

-- ! IMPORTANT ! - short names of packgaes
M.managed_separately = {
	"ts_ls",
}

-- ! IMPORTANT ! - short names of packgaes
M.disable_inlayhints = {}

M.lsp = {
	-- [ Common ]
	"yamlls",
	"jsonls",

	-- [ Unix ]
	"bashls",

	-- [ Web dev ]
	-- "ts_ls",
	"html",
	"cssls",
	-- 'tailwindcss-language-server'

	-- [ Docker ]
	-- "docker_compose_language_service",
	"dockerls",

	-- [ Neovim ]
	-- "lua_ls",

	-- [ Python ]
	"pyright",
    -- "ruff",

	-- [ Dotnet ]
	"roslyn",

	-- [ PHP ]
	"intelephense",

	-- [ Go ]
	"gopls",

	-- [ Haskell ]
	"haskell-language-server",

	-- [ Database ]
	"sqlls",

    -- [ AI ]
    -- "copilot",
}

M.dap = {
	-- "go-debug-adapter",
	-- "node-debug2-adapter",
	-- "chrome-debug-adapter",
	-- "debugpy",
	-- "cpptools",
}

-- Packages for linters and formatters also include filetypes, for easy integration with conform.nvim and nvim-lint

-- Check linters availability at: https://github.com/mfussenegger/nvim-lint
M.linters_with_ft = {
	lua = { "luacheck" },
	javascript = { "eslint" },
	typescript = { "eslint" },
	javascriptreact = { "eslint" },
	typescriptreact = { "eslint" },
}

-- Check formatters availability at: https://github.com/stevearc/conform.nvim
M.formatters_with_ft = {
	lua = { "stylua" },
	javascript = { "prettier" },
	typescript = { "prettier" },
	javascriptreact = { "prettier" },
	typescriptreact = { "prettier" },
	json = { "prettier" },
	jsonc = { "prettier" },
	html = { "prettier" },
	yaml = { "prettier" },
	python = { "black" },
	-- python = { "ruff" },
	haskell = { "ormolu" },
	cs = { "csharpier" },
	xml = { "xmlformatter" },
}

return M
