# Neovim Configuration

A modern, well-structured Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

## Features

- 🚀 **Fast startup** with lazy-loading plugins
- 🎨 **Rose Pine** color scheme
- 🔍 **Telescope** fuzzy finder with FZF native integration
- 🌳 **Treesitter** for advanced syntax highlighting
- 💼 **LSP Support** with auto-completion and diagnostics
- 📦 **Mason** for easy LSP server installation
- 🎯 **Harpoon** for quick file navigation
- ⏪ **Undotree** for undo history visualization
- 🔧 **Git integration** with vim-fugitive and gitsigns
- 🤖 **GitHub Copilot** support
- 📝 **Comment.nvim** for easy code commenting
- 🔄 **Autopairs** for automatic bracket completion
- 📊 **Lualine** status line
- 🔲 **Indent guides** for better code structure visibility

## Requirements

### Essential
- **Neovim >= 0.9.0** - The editor itself
- **Git** - For cloning this config and plugin management
- **C compiler** (gcc/clang) - Required for compiling Treesitter parsers and telescope-fzf-native
- **Make** - Required for building telescope-fzf-native and LuaSnip jsregexp

### Required for Mason (LSP server installer)
- **curl** - For downloading LSP servers
- **unzip** - For extracting downloaded packages
- **tar** and **gzip** - For extracting tar.gz archives (usually pre-installed on most systems)

### Optional but Recommended
- **Node.js** and **npm** - Required by many LSP servers (tsserver, eslint, etc.)
- **Python 3** and **pip** - Required by some LSP servers (pyright, etc.) and for installing Python-based tools
- **python-pynvim** - Enables Python provider for Neovim (optional but recommended)
- **Ripgrep** - Significantly improves Telescope's live grep performance
- **fd** - Enhanced file finder for Telescope (faster alternative to find)
- **tree-sitter-cli** - CLI tool for nvim-treesitter (optional, only needed for parser development)

## Installing Dependencies

### Arch Linux
```bash
sudo pacman -S --needed neovim git base-devel curl unzip ripgrep nodejs npm python python-pip python-pynvim fd
```

### Ubuntu/Debian
```bash
sudo apt update && sudo apt install -y neovim git build-essential curl unzip ripgrep nodejs npm python3 python3-pip python3-pynvim fd-find
```

### Fedora
```bash
sudo dnf install -y neovim git gcc make curl unzip ripgrep nodejs npm python3 python3-pip python3-neovim fd-find
```

### openSUSE
```bash
sudo zypper install -y neovim git gcc make curl unzip ripgrep nodejs npm python3 python3-pip python3-neovim fd
```

### Alpine Linux
```bash
sudo apk add neovim git build-base curl unzip ripgrep nodejs npm python3 py3-pip py3-pynvim fd
```

**Notes:**
- `tar` and `gzip` are required by Mason but are typically pre-installed on most Linux distributions. If you encounter extraction errors when Mason installs LSP servers, ensure these utilities are available.
- After installing pip, you may need to ensure the Python neovim module is installed: `pip install --user pynvim` (if not installed via system package)
- On Ubuntu/Debian, `fd` is installed as `fd-find`. You can create a symlink: `mkdir -p ~/.local/bin && ln -s $(which fdfind) ~/.local/bin/fd`
- **tree-sitter-cli** is optional and only needed for parser development. If needed, install via npm: `npm install -g tree-sitter-cli`

**Note:** If your distribution's package manager provides an older version of Neovim (< 0.9.0), you may need to use the [Neovim AppImage](https://github.com/neovim/neovim/releases) or build from source.

## Installation

1. Backup your existing Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. Clone this repository:
```bash
git clone https://github.com/chase3718/nvim.git ~/.config/nvim
```

3. Start Neovim:
```bash
nvim
```

Lazy.nvim will automatically install all plugins on first launch.

## Structure

```
.
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   └── lazy.lua        # Lazy.nvim bootstrap and setup
│   ├── init.lua            # General Neovim settings
│   ├── plugins/            # Plugin specifications
│   │   ├── autopairs.lua   # Automatic bracket pairing
│   │   ├── cmp.lua         # Autocompletion configuration
│   │   ├── comment.lua     # Easy code commenting
│   │   ├── copilot.lua     # GitHub Copilot
│   │   ├── gitsigns.lua    # Git change indicators
│   │   ├── harpoon.lua     # Quick file navigation
│   │   ├── indent-blankline.lua # Indent guides
│   │   ├── lsp.lua         # LSP Zero base
│   │   ├── lspconfig.lua   # LSP server configurations
│   │   ├── lualine.lua     # Status line
│   │   ├── mason.lua       # LSP/tool installer
│   │   ├── rose-pine.lua   # Color scheme
│   │   ├── telescope.lua   # Fuzzy finder
│   │   ├── treesitter.lua  # Syntax highlighting
│   │   ├── undotree.lua    # Undo history
│   │   └── vim-fugitive.lua # Git integration
│   └── remaps/
│       └── init.lua        # Key mappings
└── .gitignore
```

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>x` - Open file explorer
- `<C-s>` - Save file
- `jj` - Exit insert mode (in insert mode)
- `<C-q>` - Quit

### Telescope
- `<leader>ff` - Find files
- `<C-p>` - Find git files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags
- `<leader>ps` - Grep string (with input)

### LSP
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover documentation
- `<leader>vd` - Open diagnostic float
- `]d` - Next diagnostic
- `[d` - Previous diagnostic
- `<leader>vca` - Code action
- `<leader>vrn` - Rename symbol
- `<C-k>` - Signature help (insert mode)

### Harpoon
- `<leader>a` - Add file to harpoon
- `<leader>hm` - Toggle harpoon quick menu
- `<leader>hp` - Previous harpoon file
- `<leader>hn` - Next harpoon file

### Git (Fugitive)
- `<leader>gs` - Git status

### Undotree
- `<leader>u` - Toggle undotree

### Comment
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` (visual mode) - Toggle comment on selection

### Gitsigns
- `]c` / `[c` - Next/previous git hunk
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line
- `<leader>tb` - Toggle line blame

### Window Management
- `<C-h>` / `<C-l>` - Move between windows
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split

### Buffer Management
- `<Tab>` - Next buffer (normal mode)
- `<S-Tab>` - Previous buffer (normal mode)
- `<leader>bd` - Delete buffer

### Visual Mode
- `<` / `>` - Indent left/right (stays in visual mode)
- `<A-j>` / `<A-k>` - Move selected lines down/up

### Utilities
- `<Esc>` - Clear search highlights
- `<C-d>` / `<C-u>` - Scroll down/up (cursor centered)
- `n` / `N` - Next/previous search (cursor centered)
- `<leader>p` - Paste without losing register (visual mode)
- `<leader>y` - Copy to system clipboard
- `<leader>d` - Delete to void register
- `<leader>s` - Quick substitute word under cursor

### Completion (nvim-cmp)
- `<C-n>` - Next suggestion
- `<C-p>` - Previous suggestion
- `<C-Space>` - Complete
- `<CR>` - Confirm
- `<C-e>` - Abort completion (insert mode)
- `<Tab>` - Next item / expand snippet (insert mode)
- `<S-Tab>` - Previous item / jump back in snippet (insert mode)

## LSP Servers

The following LSP servers are automatically installed via Mason:
- `lua_ls` - Lua
- `rust_analyzer` - Rust
- `clangd` - C/C++

To add more servers:
1. Open Mason: `:Mason`
2. Browse available servers
3. Press `i` to install

Or add them to the `servers` table in `lua/plugins/mason.lua`.

## Customization

### Adding Plugins

Create a new file in `lua/plugins/` with the plugin specification:

```lua
return {
    "author/plugin-name",
    config = function()
        -- Plugin configuration
    end,
}
```

### Changing Color Scheme

Edit `lua/plugins/rose-pine.lua` or replace it with your preferred theme.

### Adding Key Mappings

Add your custom mappings to `lua/remaps/init.lua`:

```lua
vim.keymap.set("n", "<leader>key", function()
    -- Your command
end, { desc = "Description" })
```

## Updating

Plugins are managed by lazy.nvim. To update:

1. Open Neovim
2. Run `:Lazy update`

## Troubleshooting

### Plugins not loading
Try `:Lazy sync` to reinstall all plugins.

### LSP not working
1. Check if the server is installed: `:Mason`
2. Check LSP status: `:LspInfo`
3. Restart the LSP: `:LspRestart`

### Treesitter parser errors
Update parsers: `:TSUpdate`

### Luarocks warnings in checkhealth
Luarocks support is already disabled in this configuration (no plugins require it). If you still see warnings, verify that `lua/config/lazy.lua` contains:
```lua
require("lazy").setup({
  spec = { ... },
  rocks = {
    enabled = false,
  },
})
```

### Python provider warnings
If `:checkhealth` shows Python provider warnings:
1. Install the Python neovim module: `pip install --user pynvim`
2. Or disable the provider by adding to your `init.lua`: `vim.g.loaded_python3_provider = 0`

### Pip not found error
If you see "No module named pip":
1. On Arch: `sudo pacman -S --needed python-pip`
2. On Ubuntu/Debian: `sudo apt install python3-pip`
3. Alternative: `python3 -m ensurepip --user`

### Optional language provider warnings
Mason may show warnings for optional language tools (Ruby, PHP, Java, etc.). These are only needed if you're developing in those languages. Install them only if needed.

## License

This configuration is free to use and modify as you wish.
