local M = {}
local bars = {}
local api = vim.api
local group = api.nvim_create_augroup("HoverScrollbar", { clear = true })

local function close(win)
	local bar = bars[win]
	bars[win] = nil
	if bar and api.nvim_win_is_valid(bar) then
		api.nvim_win_close(bar, true)
	end
end

api.nvim_create_autocmd("WinClosed", {
	group = group,
	callback = function(event) close(tonumber(event.match)) end,
})

api.nvim_create_autocmd("WinScrolled", {
	group = group,
	callback = function(event)
		local win = tonumber(event.match)
		if bars[win] then M.scrollbar(win) end
	end,
})

function M.scrollbar(win)
	if not api.nvim_win_is_valid(win) or not vim.w[win]["textDocument/hover"] then
		return
	end

	local height = api.nvim_win_get_height(win)
	local total = api.nvim_win_text_height(win, {}).all
	if total <= height then
		close(win)
		return
	end

	-- Screen-line measurements account for wrapping and concealed Markdown fences.
	local view = api.nvim_win_call(win, vim.fn.winsaveview)
	local offset = api.nvim_win_text_height(win, {
		end_row = view.topline - 1,
		end_vcol = view.skipcol,
	}).all
	local size = math.max(1, math.floor(height * height / total))
	local row = math.floor((height - size) * math.min(offset / (total - height), 1))
	local config = {
		relative = "win",
		win = win,
		row = row,
		col = api.nvim_win_get_width(win),
		width = 1,
		height = size,
		border = "none",
		style = "minimal",
		focusable = false,
		zindex = api.nvim_win_get_config(win).zindex + 1,
	}

	if bars[win] and api.nvim_win_is_valid(bars[win]) then
		api.nvim_win_set_config(bars[win], config)
	else
		local buf = api.nvim_create_buf(false, true)
		vim.bo[buf].bufhidden = "wipe"
		config.noautocmd = true
		bars[win] = api.nvim_open_win(buf, false, config)
		vim.wo[bars[win]].winhighlight = "NormalFloat:PmenuThumb,EndOfBuffer:PmenuThumb"
	end
end

return M
