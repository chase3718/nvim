return {
	"rcarriga/nvim-notify",
	lazy = true,
	config = function()
		require("notify").setup({
			stages = "fade_in_slide_out",
			timeout = 3000,
			background_colour = "#1a1a1a",
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
		})
		vim.notify = require("notify")
	end,
}
