vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) - Use oil.nvim instead

-- Disable the spacebar key"s default behaviour in Normal and Visual mode
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- Disable <C-M> as enter
vim.keymap.set("n", "<C-M>", "<Nop>", { noremap = true, silent = true })

local opts = { noremap = true, silent = true }

-- vim.keymap.set("n", "qq", ":q<CR>", opts)
-- vim.keymap.set("n", "ww", ":w<CR>", opts)
-- vim.keymap.set("n", "wa", ":wa<CR>", opts)

-- Move selected lines (even adds tabs, opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Kepp cursor at position when appending bottom line to the end
vim.keymap.set("n", "J", "mzJ`z", opts)
-- Keep cursor in the middle during half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
-- Keep cursor in the middle during search
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Yank into the system clipboard
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)

-- Paste from the system clipboard
vim.keymap.set("n", "<leader>pp", '"+p', opts)
vim.keymap.set("v", "<leader>pp", '"+p', opts)
vim.keymap.set("n", "<leader>PP", '"+P', opts)

-- Delete into the void register
vim.keymap.set("n", "<leader>d", '"_d', opts)
vim.keymap.set("v", "<leader>d", '"_d', opts)
-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Rename all instances of a word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Run terminal in a split view
vim.keymap.set("n", "<leader>m", [[:vnew<Enter>:terminal ]], opts)
vim.keymap.set("n", "<leader>rp", function() -- Run Python
	local file_path = vim.fn.expand "%:p"
	local file_dir = vim.fn.expand "%:p:h"
	vim.cmd "vnew"
	vim.cmd("terminal cd " .. file_dir .. " && python3 " .. file_path)
end, opts)
vim.keymap.set("n", "<leader>rj", function() -- Run Node
	local file_path = vim.fn.expand "%:p"
	local file_dir = vim.fn.expand "%:p:h"
	vim.cmd "vnew"
	vim.cmd("terminal cd " .. file_dir .. " && node " .. file_path)
end, opts)

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window in vertical position
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window in horizontal position
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows same size

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize  -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Navigate between splits
-- vim.keymap.set("n", "<C-gk>", ":wincmd k<CR>", opts)
-- vim.keymap.set("n", "<C-gj>", ":wincmd j<CR>", opts)
-- vim.keymap.set("n", "<C-gh>", ":wincmd h<CR>", opts)
-- vim.keymap.set("n", "<C-gl>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) -- go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) -- go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leaqer>q", vim.diagnostic.setloclist, opts)
