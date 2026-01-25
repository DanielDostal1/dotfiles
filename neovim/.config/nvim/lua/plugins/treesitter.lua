return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	opts = {
		ensure_installed = {
            -- Core
            "bash", "c", "lua", "luadoc", "vim", "vimdoc", "query", "markdown", "markdown_inline", "regex", "gitcommit", "gitignore", "json",

            -- Web (TS/JS/HTML/CSS)
            "html", "css", "javascript", "typescript", "tsx",

            -- .NET (C#)
            "c_sharp",

            -- Database
            "sql",

            -- Python
            "python",

            -- Haskell
            "haskell",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
	},
}
