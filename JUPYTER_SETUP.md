# Jupyter Notebook Setup Guide

Your Neovim is now configured with **Molten.nvim** for full interactive Jupyter notebook support!

## Prerequisites

### 1. Install Python Packages

```bash
# Required packages
pip install jupyter ipython pynvim

# Optional but recommended for full functionality
pip install cairosvg plotly kaleido pnglatex pyperclip
pip install jupyter-console  # For better REPL experience
```

### 2. Terminal Requirements

For inline image rendering, you need a terminal that supports images:

**Recommended terminals:**
- **Kitty** (best support) - `brew install --cask kitty`
- **iTerm2** with imgcat
- **WezTerm**
- **Alacritty** (with sixel support)

If using macOS Terminal or other terminals, images will open in external viewers instead.

### 3. Verify Installation

```bash
# Check jupyter is installed
jupyter --version

# Check ipython is installed
ipython --version

# Check pynvim is available
python -c "import pynvim; print('pynvim OK')"
```

## Usage

### Starting a Kernel

1. Open a Python file or Jupyter notebook (`.ipynb`)
2. Press `<leader>mi` to initialize a kernel
3. Select kernel (usually "python3")

### Working with Notebooks

**Evaluate code:**
- `<leader>me` - Evaluate current line
- Visual mode + `<leader>me` - Evaluate selection
- `<leader>mr` - Re-evaluate current cell

**Navigate cells:**
- `]c` - Next cell
- `[c` - Previous cell

**Manage outputs:**
- `<leader>mo` - Show output
- `<leader>mh` - Hide output
- `<leader>md` - Delete cell

**Kernel control:**
- `<leader>mx` - Interrupt kernel (stop execution)
- `<leader>mX` - Restart kernel
- `<leader>mq` - Quit/deinit kernel
- `<leader>mI` - Show kernel info

**Import/Export:**
- `<leader>ms` - Save session
- `<leader>ml` - Load session
- `<leader>mE` - Export output

### Working with .ipynb Files

Molten works directly with `.ipynb` files. When you open a notebook:

1. `:MoltenInit` to start a kernel
2. Navigate cells with `]c` and `[c`
3. Execute cells with `<leader>me`
4. View outputs inline or in floating windows

### Working with Regular Python Files

You can use Molten with regular `.py` files by marking code cells:

```python
# %%
import numpy as np
import matplotlib.pyplot as plt

# %%
x = np.linspace(0, 10, 100)
y = np.sin(x)
plt.plot(x, y)
plt.show()

# %%
print("Results:", y.mean())
```

The `# %%` markers define cells that can be executed independently.

### Jupytext Integration

Edit notebooks as Python files using Jupytext:

```bash
# Open a notebook as Python file
nvim notebook.ipynb  # Will open as .py file automatically
```

Jupytext syncs changes between `.ipynb` and `.py` formats.

## Tips

1. **Start simple:** Begin with `:MoltenInit` in a Python file
2. **Check output:** Use `<leader>mo` if output doesn't appear automatically
3. **Restart kernel:** Use `<leader>mX` if kernel gets stuck
4. **Cell markers:** Use `# %%` to create cells in `.py` files
5. **Virtual text:** Outputs can appear as virtual text inline (configurable)

## Troubleshooting

**"No kernel found" error:**
```bash
# Reinstall jupyter
pip install --upgrade jupyter ipython pynvim
```

**Images not showing:**
- Check you're using Kitty or supported terminal
- Set `vim.g.molten_image_provider = 'none'` to use external viewer
- Install image dependencies: `pip install cairosvg pillow`

**Slow execution:**
- Interrupt kernel: `<leader>mx`
- Restart kernel: `<leader>mX`
- Check kernel process: `:MoltenInfo`

**Plugin not loading:**
```bash
# In Neovim, update remote plugins
:UpdateRemotePlugins

# Restart Neovim
```

## Advanced Configuration

The configuration is in `lua/custom/plugins/molten.lua`. Key options:

- `vim.g.molten_auto_open_output` - Auto-show output (default: false)
- `vim.g.molten_image_location` - 'float' or 'buffer'
- `vim.g.molten_output_win_max_height` - Max output window height

## Integration with Neotest

Molten works alongside neotest. Use:
- Neotest for running unit tests (`<leader>tt`)
- Molten for interactive data science work (`<leader>me`)

## Resources

- [Molten.nvim Documentation](https://github.com/benlubas/molten-nvim)
- [Image.nvim Documentation](https://github.com/3rd/image.nvim)
- [Jupytext Documentation](https://github.com/mwouts/jupytext)

Enjoy your interactive Python notebooks in Neovim! 🚀
