# Custom Neovim Configuration

This directory contains custom plugins and configurations that extend the base kickstart.nvim setup.

## Overview

This configuration is built on top of [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim), providing a solid foundation with additional plugins tailored for:

- **AI-assisted development** (Copilot)
- **Data science workflows** (Jupyter notebooks, Molten)
- **Testing** (Neotest)
- **Enhanced navigation** (Flash, Precognition)
- **Learning tools** (Hardtime, Precognition)

## Plugin Categories

### 🤖 AI & Copilot

#### Copilot Chat
GitHub Copilot chat integration with pre-configured prompts.

- **Keymaps**: `<leader>a*` prefix for various actions
- **Features**: Code explanation, refactoring, test generation, commit messages

#### Copilot.vim
GitHub Copilot inline code suggestions.

- **Keymaps**: `<C-y>` accept, `<C-j/k>` navigate, `<C-d>` dismiss

### 📊 Notebooks & Data Science

#### Molten.nvim
Interactive Jupyter notebook support directly in Neovim.

- **Requirements**: `jupyter`, `ipython`, `pynvim`, and optional image rendering packages
- **Keymaps**: `<leader>m*` prefix for kernel and cell operations
- **Features**: 
  - Execute code cells inline
  - Display outputs with image support
  - Navigate between cells
  - Export/import notebooks

#### Jupytext.nvim
Edit Jupyter notebooks as Python/Markdown files.

- **Features**: Bidirectional conversion between `.ipynb` and `.py`/`.md`
- **Note**: Includes extensive error handling for malformed notebooks

#### Quarto.nvim
Support for Quarto documents (`.qmd` files).

- **Features**: LSP integration for Python, R, and Julia chunks

### 🧪 Testing

#### Neotest
Modern testing framework with support for multiple languages.

- **Supported**: Python (pytest), Go (go test), JavaScript/TypeScript (vitest)
- **Keymaps**: `<leader>t*` prefix
- **Features**: Run tests, debug, watch mode, test summary

### 🧭 Navigation

#### Flash.nvim
Enhanced navigation with labeled jumps.

- **Keymaps**: `s` for jump, `S` for treesitter selection
- **Features**: Jump anywhere on screen with 2-3 keystrokes

#### Precognition.nvim
Real-time motion hints for learning efficient Vim movements.

- **Keymaps**: `<leader>tp` toggle, `<leader>pp` peek
- **Features**: Shows available motions as you navigate

### 🔍 Search & Replace

#### Spectre
Project-wide find and replace with preview.

- **Keymaps**: `<leader>S` toggle, `<leader>sw` search word
- **Features**: Live preview, regex support, multiple replace engines

### 🐛 Diagnostics

#### Trouble.nvim
Pretty diagnostics, references, and quickfix list.

- **Keymaps**: `<leader>x*` prefix
- **Features**: Organized diagnostic display, LSP integration

### 📚 Learning Tools

#### Hardtime.nvim
Break bad Vim habits by gently blocking repetitive motions.

- **Keymaps**: `<leader>th` toggle
- **Features**: Encourages efficient motions (w, b, }, {) over repetitive hjkl

### 🔧 Git

#### LazyGit.nvim
Terminal UI for Git operations.

- **Keymaps**: `<leader>gg` open, `<leader>gc` current file
- **Requirements**: `lazygit` binary installed

## Keymap Reference

See `keymaps.lua` for a complete reference of all custom keymaps organized by category.

Quick reference:
- `<leader>` = Space (configured in `init.lua`)
- AI: `<leader>a*`
- Testing: `<leader>t*`
- Notebooks: `<leader>m*`
- Diagnostics: `<leader>x*`
- Git: `<leader>g*`
- Search: `<leader>s*`

**Note**: Some keymaps may have conflicts (documented in `keymaps.lua`). The last loaded plugin's keymap will take precedence.

## Configuration Files

- `plugins/*.lua` - Individual plugin configurations
- `keymaps.lua` - Centralized keymap reference
- `README.md` - This file

## Dependencies

### Required System Tools
- `git`, `make`, `unzip`, C compiler
- `ripgrep`, `fd-find`
- Clipboard tool (xclip/xsel/win32yank)

### Language-Specific
- **Python**: `jupyter`, `ipython`, `pynvim` (for Molten)
- **Go**: `go` (for Go LSP and tests)
- **Node.js**: `npm` (for TypeScript/JavaScript)

### Optional
- **LazyGit**: For Git UI (`brew install lazygit` on macOS)
- **Image rendering**: `cairosvg`, `plotly`, `kaleido` (for Molten image output)

## Tips

1. **First Time Setup**: Run `:Lazy` to view and install all plugins
2. **Check Health**: Run `:checkhealth` to verify dependencies
3. **Keymap Discovery**: Use `:Telescope keymaps` or `which-key` (`<leader>`) to discover keymaps
4. **Learning Mode**: Enable Hardtime and Precognition when learning Vim motions
5. **Notebook Workflow**: Use Molten for interactive Python development, Jupytext for editing `.ipynb` files

## Customization

All custom plugins are in `lua/custom/plugins/`. To add a new plugin:

1. Create a new file in `lua/custom/plugins/`
2. Return a plugin spec table (see existing files for examples)
3. The plugin will be automatically loaded via `{ import = 'custom.plugins' }` in `lazy-plugins.lua`

## Troubleshooting

### Molten not working
- Verify Python dependencies: `pip install jupyter ipython pynvim`
- Check kernel initialization: `<leader>mi`
- Review output: `<leader>mo`

### Copilot not suggesting
- Verify GitHub Copilot subscription
- Check filetype is enabled in `copilot-vim.lua`
- Try `<C-l>` to manually trigger suggestions

### LSP not starting
- Run `:Mason` to install language servers
- Check `:LspInfo` for server status
- Verify language server is in `ensure_installed` list

## License

This configuration extends kickstart.nvim and follows the same license terms.
