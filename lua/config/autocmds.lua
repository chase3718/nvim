-- Autocommands for opening certain buffer types in new tabs
local augroup = vim.api.nvim_create_augroup("OpenInTab", { clear = true })

-- Open help files in a new tab
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup,
	pattern = "*",
	callback = function(args)
		if vim.bo[args.buf].buftype == "help" then
			-- Only move to new tab if not already in one
			vim.cmd("wincmd T")
		end
	end,
})

-- Open quickfix in a new tab
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "qf",
	callback = function()
		vim.cmd("wincmd T")
	end,
})
