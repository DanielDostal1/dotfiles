-- Set leader key BEFORE loading lazy.nvim to ensure mappings work correctly
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core modules
require "bootstrap"
require "core.options"
require "core.keymaps"


-- TODO: fzf telescope grep
-- TODO: tmux
-- TODO: overseer
