return {
	"tpope/vim-fugitive",
	version = "*",
	config = function()
		-- Open Git status in a horizontal split below
		vim.keymap.set("n", "<leader>gs", function()
			vim.cmd("botright Git")
		end, { desc = "Git status" })
	end,
}
