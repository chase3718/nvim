return {
	"rose-pine/nvim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "auto", -- auto, main, moon, or dawn
			dark_variant = "main",
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},
		})

		vim.cmd.colorscheme("rose-pine")
	end,
}
