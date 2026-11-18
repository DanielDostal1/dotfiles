-- Run from the config directory: nvim --headless -i NONE -u init.lua -l tests/typescript-docs.lua
local format = require("typescript-tools.protocol.utils").tsserver_make_tags
local code = "```ts\nconst answer = 42;\n```"
local expected = "\n_@example_\n\n" .. code

assert(format({ { name = "example", text = code } }) == expected)
assert(format({ {
	name = "example",
	text = {
		{ kind = "text", text = "```ts\n" },
		{ kind = "text", text = "const answer = 42;\n```" },
	},
} }) == expected)
assert(format({}) == "")
assert(format({ { name = "returns", text = "value" } }) == "\n_@returns_ — value")
local tags = { { name = "example", text = code }, { name = "deprecated" } }
local before = vim.deepcopy(tags)
format(tags)
assert(vim.deep_equal(tags, before), "formatter mutated input tags")

local parser = vim.treesitter.get_string_parser(expected, "markdown")
local tree = parser:parse()[1]
local query = vim.treesitter.query.parse("markdown", "(fenced_code_block) @code")
local blocks = 0
for _ in query:iter_captures(tree:root(), expected) do blocks = blocks + 1 end
assert(blocks == 1, "example was not parsed as a code block")

-- Exercise the actual hover and completion converters with tsserver responses.
local function response(module, params, body)
	local result
	local co = coroutine.create(require("typescript-tools.protocol." .. module).handler)
	assert(coroutine.resume(co, function() end, function(value) result = value end, params))
	assert(coroutine.resume(co, body))
	assert(coroutine.status(co) == "dead")
	return assert(result)
end

local file = vim.fn.stdpath("config") .. "/init.lua"
local hover = response("text_document.hover", {
	textDocument = { uri = vim.uri_from_fname(file) },
	position = { line = 0, character = 0 },
}, {
	documentation = { { text = "Description" } },
	tags = { { name = "example", text = code } },
	displayString = "const answer: 42",
	start = { line = 1, offset = 1 },
	["end"] = { line = 1, offset = 7 },
})
assert(hover.contents[3] == expected)
assert(hover.contents[1].value == "```typescript\nconst answer: 42\n```\n")

local item = response("text_document.completion.resolve", {
	data = { file = file, line = 0, character = 0 },
	kind = 6, insertText = "answer", label = "answer",
}, { {
	documentation = { { text = "Description" } },
	tags = { { name = "example", text = code } },
	displayParts = { { text = "const answer: 42" } },
} })
assert(item.documentation.kind == "markdown")
assert(item.documentation.value == "Description\n" .. expected)
assert(item.detail == "const answer: 42" and item.insertText == "answer")
print("PASS: TypeScript example Markdown, hover, and completion")
