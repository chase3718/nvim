-- Load vim options first (before plugins)
require("config.options")

-- Load autocommands
require("config.autocmds")

-- Load plugin manager and plugins
require("config.lazy")

-- Load keybindings (after plugins)
require("remaps")
