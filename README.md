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
- 🔧 **Git integration** with vim-fugitive, gitsigns, and snacks
- 🤖 **GitHub Copilot** support
- 📝 **Comment.nvim** for easy code commenting
- 🔄 **Autopairs** for automatic bracket completion
- 📊 **Lualine** status line
- 🔲 **Indent guides** for better code structure visibility
- ⌨️ **Which-Key** for keymap hints and discovery
- 📋 **Todo Comments** highlighting and management
- 🔍 **Nvim-Lint** for linting support
- 📑 **Bufferline** for buffer tabs
- 💬 **Noice** for better UI messages and popups
- 🎨 **Mini.icons** for consistent icon support
- 🌲 **Neo-tree** file explorer
- 🔧 **Refactoring** tools for code refactoring
- 🔆 **Vim-illuminate** for highlighting word references
- 🍱 **Snacks** for quality of life improvements
- 🏠 **Dashboard** for beautiful start screen

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
- **Ripgrep** - Significantly improves Telescope's live grep performance
- **fd** - Enhanced file finder for Telescope (faster alternative to find)
- **lazygit** - Terminal UI for git (used by snacks.nvim, optional)

### Optional for Development
- **Node.js** and **npm** - Required by many LSP servers (tsserver, eslint, etc.)
- **Python 3** and **pip** - Required by some LSP servers (pyright, etc.) and for installing Python-based tools
- **tree-sitter-cli** - CLI tool for nvim-treesitter (optional, only needed for parser development)

**Note:** Node.js, Perl, and Ruby providers are disabled by default in this configuration. These providers are only needed for legacy Vim plugins that use the remote plugin system. Modern plugins (including GitHub Copilot which uses LSP) do not require these providers. If you have a specific plugin that requires a provider, you can enable it by removing the provider disable lines from `lua/config/options.lua`.

## Installing Dependencies

### Arch Linux
```bash
sudo pacman -S --needed neovim git base-devel curl unzip ripgrep fd
# Optional: lazygit for git UI integration
# sudo pacman -S lazygit
```

### Ubuntu/Debian
```bash
sudo apt update && sudo apt install -y neovim git build-essential curl unzip ripgrep fd-find
# Optional: lazygit for git UI integration (may need to install from release page or PPA)
```

### Fedora
```bash
sudo dnf install -y neovim git gcc make curl unzip ripgrep fd-find
# Optional: lazygit for git UI integration
# sudo dnf install lazygit
```

### openSUSE
```bash
sudo zypper install -y neovim git gcc make curl unzip ripgrep fd
# Optional: lazygit for git UI integration
```

### Alpine Linux
```bash
sudo apk add neovim git build-base curl unzip ripgrep fd
# Optional: lazygit for git UI integration
```

**Notes:**
- `tar` and `gzip` are required by Mason but are typically pre-installed on most Linux distributions. If you encounter extraction errors when Mason installs LSP servers, ensure these utilities are available.
- On Ubuntu/Debian, `fd` is installed as `fd-find`. You can create a symlink: `mkdir -p ~/.local/bin && ln -s $(which fdfind) ~/.local/bin/fd`
- **tree-sitter-cli** is optional and only needed for parser development. If needed, install via npm: `npm install -g tree-sitter-cli`
- **lazygit** is optional but recommended for the `<leader>gg` git UI keybinding. Without it, the keybinding simply won't be registered.

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
│   │   ├── bufferline.lua  # Buffer tabs
│   │   ├── cmp.lua         # Autocompletion configuration
│   │   ├── comment.lua     # Easy code commenting
│   │   ├── copilot.lua     # GitHub Copilot
│   │   ├── dashboard.lua   # Start screen
│   │   ├── gitsigns.lua    # Git change indicators
│   │   ├── harpoon.lua     # Quick file navigation
│   │   ├── indent-blankline.lua # Indent guides
│   │   ├── lsp.lua         # LSP Zero base
│   │   ├── lspconfig.lua   # LSP server configurations
│   │   ├── lualine.lua     # Status line
│   │   ├── mason.lua       # LSP/tool installer
│   │   ├── mini-icons.lua  # Icon provider
│   │   ├── neo-tree.lua    # File explorer
│   │   ├── noice.lua       # Better UI for messages and popups
│   │   ├── nui.lua         # UI component library
│   │   ├── nvim-lint.lua   # Linting framework
│   │   ├── nvim-notify.lua # Notification manager
│   │   ├── refactoring.lua # Refactoring tools
│   │   ├── rose-pine.lua   # Color scheme
│   │   ├── snacks.lua      # QoL improvements
│   │   ├── telescope.lua   # Fuzzy finder
│   │   ├── todo-comments.lua # TODO highlighting
│   │   ├── treesitter.lua  # Syntax highlighting
│   │   ├── undotree.lua    # Undo history
│   │   ├── vim-fugitive.lua # Git integration
│   │   ├── vim-illuminate.lua # Reference highlighting
│   │   └── which-key.lua   # Keymap hints
│   └── remaps/
│       └── init.lua        # Key mappings
└── .gitignore
```

## Key Mappings

### VSCode-like Keybindings
These keybindings provide a VSCode-like experience while maintaining Neovim's powerful motions:
- `<C-b>` - Toggle file browser (Neo-tree) - works both outside and inside the file explorer
- `Ctrl-\`` - Open new terminal in a horizontal split below the current view
- `<C-w>` - Close current buffer/file
- `<C-s>` - Save file

**Note:** Since `<C-w>` is overridden, window navigation has been remapped:
- `<C-h>` / `<C-l>` - Move to left/right window (unchanged)
- `<leader>wj` / `<leader>wk` - Move to down/up window (replaces `<C-w>j` / `<C-w>k`)
- `<leader>wq` - Close current window
- `<leader>wo` - Close all other windows
- Split commands remain at `<leader>sv` (vertical) and `<leader>sh` (horizontal)

### General
- `<Space>` - Leader key
- `<leader>e` - Toggle Neo-tree (cwd)
- `<leader>E` - Toggle Neo-tree (current file)
- `jj` - Exit insert mode (in insert mode)
- `<C-q>` - Quit

### Telescope
- `<leader>ff` - Find files
- `<C-p>` - Find git files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags
- `<leader>ft` - Find todos
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

### Snacks (Git)
- `<leader>gg` - Lazygit (requires lazygit to be installed)
- `<leader>gb` - Git blame line
- `<leader>gB` - Git browse

### Undotree
- `<leader>u` - Toggle undotree

### Todo Comments
- `]t` / `[t` - Next/previous todo comment

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
- `[b` / `]b` - Previous/next buffer (Bufferline)
- `<leader>bp` - Toggle pin buffer
- `<leader>bP` - Delete non-pinned buffers
- `<leader>bo` - Delete other buffers
- `<leader>br` - Delete buffers to the right
- `<leader>bl` - Delete buffers to the left

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
- `<leader>cl` - Trigger linting manually

### Vim Illuminate (Reference Highlighting)
- `]]` - Go to next reference
- `[[` - Go to previous reference

### Refactoring
- `<leader>re` - Extract function (visual mode)
- `<leader>rf` - Extract to file (visual mode)
- `<leader>rv` - Extract variable (visual mode)
- `<leader>ri` - Inline variable
- `<leader>rI` - Inline function
- `<leader>rb` - Extract block
- `<leader>rbf` - Extract block to file
- `<leader>rr` - Select refactor (visual mode)

### Noice
- `<leader>nl` - Show last message
- `<leader>nh` - Show message history
- `<leader>na` - Show all messages
- `<leader>nd` - Dismiss all notifications

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
Node.js, Perl, and Ruby providers are disabled by default in this configuration to reduce checkhealth warnings. These providers are only needed for legacy Vim plugins that use the remote plugin system. Modern plugins (including GitHub Copilot which uses LSP) do not require these providers.

If you have a specific plugin that requires a provider, edit `lua/config/options.lua` and remove or comment out the relevant disable lines:
```lua
-- vim.g.loaded_node_provider = 0  -- Remove to enable Node.js provider
-- vim.g.loaded_perl_provider = 0  -- Remove to enable Perl provider
-- vim.g.loaded_ruby_provider = 0  -- Remove to enable Ruby provider
```

### Checkhealth warnings about missing tools
Some checkhealth warnings are for optional features:
- **lazygit** - Optional git UI tool. Install for `<leader>gg` keybinding.
- **tree-sitter-cli** - Only needed for treesitter parser development.
- **Image rendering tools** (kitty, wezterm) - Only needed for advanced image features in snacks.nvim.
- **LaTeX/Mermaid tools** - Only needed for rendering math expressions and diagrams in markdown files.

## License

This configuration is free to use and modify as you wish.
