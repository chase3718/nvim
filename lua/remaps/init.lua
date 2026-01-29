-- Leader key is set in lazy.lua before plugin loading
-- Basic remaps
vim.keymap.set("n", "<leader>x", vim.cmd.Ex, { desc = "Open file explorer" })
vim.keymap.set("n", "<C-s>", vim.cmd.w, { desc = "Save file" })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<C-q>", vim.cmd.q, { desc = "Quit" })
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-q>", vim.cmd.q)

-- from primeagen tutorial - maybe replace these over time


