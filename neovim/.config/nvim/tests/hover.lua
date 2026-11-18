-- Run from the config directory with the normal startup (not script mode):
-- nvim --headless -i NONE -c 'lua local ok, e = pcall(dofile, "tests/hover.lua"); if not ok then print(e); vim.cmd("cquit") end' +qa
local api = vim.api
vim.o.columns = 120
vim.o.lines = 40

local function scrollbar(win)
	for _, candidate in ipairs(api.nvim_list_wins()) do
		if api.nvim_win_get_config(candidate).win == win then return candidate end
	end
end

local function open(lines, width, height)
	local buf, win = vim.lsp.util.open_floating_preview(lines, "markdown", {
		focus_id = "textDocument/hover",
		max_width = width,
		max_height = height,
	})
	require("render-markdown").render({ buf = buf, win = win })
	assert(vim.wait(1000, function() return vim.wo[win].concealcursor == "nvic" end))
	return win
end

local lines = {}
for i = 1, 60 do lines[i] = "Line " .. i end
local win = open(lines, 88, 24)
assert(vim.wait(1000, function() return scrollbar(win) ~= nil end), "missing scrollbar")
local bar = scrollbar(win)
local config = api.nvim_win_get_config(bar)
assert(config.row == 0 and config.height < 24)
assert(config.col == api.nvim_win_get_width(win) and not config.focusable)
api.nvim_set_current_win(win)
vim.fn.winrestview({ lnum = 60, topline = 37 })
-- Headless scripts do not run the normal input loop that emits WinScrolled.
api.nvim_exec_autocmds("WinScrolled", { pattern = tostring(win) })
config = api.nvim_win_get_config(bar)
assert(config.row + config.height == api.nvim_win_get_height(win), "thumb did not reach bottom")
local bar_buf = api.nvim_win_get_buf(bar)
api.nvim_win_close(win, true)
assert(not api.nvim_win_is_valid(bar), "orphan scrollbar window")
assert(not api.nvim_buf_is_valid(bar_buf), "orphan scrollbar buffer")

-- A single wrapped buffer line can still need a scrollbar.
win = open({ string.rep("word ", 100) }, 20, 8)
assert(vim.wait(1000, function() return scrollbar(win) ~= nil end), "wrapped overflow missed")
bar = scrollbar(win)
api.nvim_win_call(win, function()
	vim.fn.winrestview({ lnum = 1, col = 150, topline = 1, skipcol = 100 })
end)
api.nvim_exec_autocmds("WinScrolled", { pattern = tostring(win) })
assert(api.nvim_win_get_config(bar).row > 0, "wrapped scrolling did not move thumb")
api.nvim_win_close(win, true)

-- Concealed fence lines must not produce a false overflow indicator.
win = open({ "```typescript", "const answer = 42;", "```" }, 88, 24)
require("core.hover").scrollbar(win)
assert(not scrollbar(win), "short hover has a scrollbar")
api.nvim_win_close(win, true)
print("PASS: hover scrollbar overflow, scrolling, wrapping, and cleanup")
