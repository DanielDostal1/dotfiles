require "core.options"
require "core.keymaps"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

local themes = require "plugins.colorthemes"

require("lazy").setup {
	themes.plugins,
	require "plugins.alpha",
	require "plugins.autocompletion",
	require "plugins.copilot",
	require "plugins.games",
	require "plugins.gitsigns",
	require "plugins.harpoon",
	require "plugins.indent-blankline",
	require "plugins.lazygit",
	require "plugins.lsp",
	require "plugins.lualine",
	-- require "plugins.mini-ai",
	require "plugins.misc",
	require "plugins.none-ls",
	require "plugins.oil",
	require "plugins.tailwind-tools",
	require "plugins.telescope",
	require "plugins.treesitter",
	require "plugins.typescript-tools",
	require "plugins.undotree",

	-- TODO: tmux
	-- TODO: overseer
}

themes.setup()
