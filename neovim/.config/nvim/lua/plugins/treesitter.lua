return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		local query = require("vim.treesitter.query")
		local query_opts = vim.fn.has("nvim-0.10") == 1 and { force = true, all = false } or true
		local html_script_type_languages = {
			importmap = "json",
			module = "javascript",
			["application/ecmascript"] = "javascript",
			["text/ecmascript"] = "javascript",
		}
		local non_filetype_match_injection_language_aliases = {
			ex = "elixir",
			pl = "perl",
			sh = "bash",
			uxn = "uxntal",
			ts = "typescript",
		}

		local function capture_node(match, id)
			local node = match[id]
			if type(node) == "table" then
				return node[#node]
			end
			return node
		end

		local function parser_from_info_string(alias)
			local match = vim.filetype.match({ filename = "a." .. alias })
			return match or non_filetype_match_injection_language_aliases[alias] or alias
		end

		query.add_predicate("nth?", function(match, _, _bufnr, pred)
			local node = capture_node(match, pred[2])
			local n = tonumber(pred[3])
			if node and node:parent() and node:parent():named_child_count() > n then
				return node:parent():named_child(n) == node
			end
			return false
		end, query_opts)

		query.add_predicate("is?", function(match, _, bufnr, pred)
			local locals = require("nvim-treesitter.locals")
			local node = capture_node(match, pred[2])
			local types = { unpack(pred, 3) }
			if not node then
				return true
			end
			local _, _, kind = locals.find_definition(node, bufnr)
			return vim.tbl_contains(types, kind)
		end, query_opts)

		query.add_predicate("kind-eq?", function(match, _, _bufnr, pred)
			local node = capture_node(match, pred[2])
			local types = { unpack(pred, 3) }
			if not node then
				return true
			end
			return vim.tbl_contains(types, node:type())
		end, query_opts)

		query.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
			local node = capture_node(match, pred[2])
			if not node then
				return
			end
			local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
			local configured = html_script_type_languages[type_attr_value]
			if configured then
				metadata["injection.language"] = configured
			else
				local parts = vim.split(type_attr_value, "/", {})
				metadata["injection.language"] = parts[#parts]
			end
		end, query_opts)

		query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
			local node = capture_node(match, pred[2])
			if not node then
				return
			end
			local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
			metadata["injection.language"] = parser_from_info_string(injection_alias)
		end, query_opts)

		query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
			local id = pred[2]
			local node = capture_node(match, id)
			if not node then
				return
			end
			local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
			if not metadata[id] then
				metadata[id] = {}
			end
			metadata[id].text = string.lower(text)
		end, query_opts)

		vim.treesitter.query.set(
			"markdown",
			"injections",
			[[
(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
]]
		)
	end,
	opts = {
		ensure_installed = {
            -- Core
			"bash", "c", "lua", "luadoc", "vim", "vimdoc", "query",
			"markdown", "markdown_inline",
			"regex", "gitcommit", "gitignore", "json", "comment", "jsdoc", "xml",

            -- Web (TS/JS/HTML/CSS)
            "html", "css", "javascript", "typescript", "tsx",

            -- .NET (C#)
            "c_sharp",

            -- Database
            "sql",

            -- Python
            "python",

            -- Haskell
            -- "haskell",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = false },
	},
}
