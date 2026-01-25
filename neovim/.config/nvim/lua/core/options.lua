local opt = vim.opt

-- General
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers
opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard (requires wl-clipboard)

-- Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true          -- Use spaces instead of tabs
opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "typescriptreact", "json" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})


-- Search
opt.ignorecase = true         -- Ignore case when searching...
opt.smartcase = true          -- ...unless uppercase letters are used
opt.hlsearch = false
opt.incsearch = true

-- UI
opt.termguicolors = true      -- True color support
opt.signcolumn = "yes"        -- Always show sign column (prevents shift)
opt.splitbelow = true         -- Split horizontal windows below
opt.splitright = true         -- Split vertical windows right
opt.scrolloff = 8             -- Keep 8 lines context when scrolling
opt.updatetime = 50           -- Faster completion/updates
