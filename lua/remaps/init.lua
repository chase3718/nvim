-- Leader key is set in lazy.lua before plugin loading

-- Basic remaps
vim.keymap.set("n", "<leader>x", vim.cmd.Ex, { desc = "Open file explorer" })
vim.keymap.set("n", "<C-s>", vim.cmd.w, { desc = "Save file" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<C-q>", vim.cmd.q, { desc = "Quit" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Better window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Paste without losing register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without losing register" })

-- Copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to system clipboard" })

-- Delete to void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Quick substitute
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Quick substitute word" })

-- Make file executable
vim.keymap.set("n", "<leader>mx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-q>", vim.cmd.q)

-- from primeagen tutorial - maybe replace these over time

-- ===================================
-- VSCode-like keybindings
-- ===================================

-- Ctrl-b: Toggle file browser (like VSCode's sidebar)
vim.keymap.set("n", "<C-b>", function()
	require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end, { desc = "Toggle file browser" })

-- Ctrl-`: Open new terminal in new tab (like VSCode)
-- Terminal tab counter to keep track of terminal tabs
local terminal_count = 0
vim.keymap.set({"n", "i", "t"}, "<C-`>", function()
	terminal_count = terminal_count + 1
	vim.cmd("tabnew")
	vim.cmd("terminal")
	vim.cmd("startinsert")
	-- Rename the tab to show it's a terminal
	vim.cmd("file Terminal " .. terminal_count)
end, { desc = "Open terminal in new tab" })

-- Ctrl-w: Close current buffer/file (override Neovim's default window command prefix)
-- First, we need to unmap the default Ctrl-w behavior, then remap it
vim.keymap.set("n", "<C-w>", ":bdelete<CR>", { desc = "Close buffer" })

-- Restore essential window navigation that used Ctrl-w as prefix
-- These now use Alt as the modifier to avoid conflicts
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<A-v>", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<A-s>", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<A-q>", "<C-w>q", { desc = "Close current window" })
vim.keymap.set("n", "<A-o>", "<C-w>o", { desc = "Close all other windows" })


