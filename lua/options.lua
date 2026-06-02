-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local set = vim.opt

-- Line numbers
set.number = true
set.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
set.mouse = 'a'

-- Indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.expandtab = true

-- Don't show the mode, since it's already in the status line
set.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Appearance
set.termguicolors = true
set.background = 'dark'

-- Enable break indent
set.breakindent = true

-- Backspace behaviour
set.backspace = 'indent,eol,start'

-- dw/diw/ciw works on hyphenated words
set.iskeyword:append('-')

-- Disable swap/backup, use persistent undo instead
set.swapfile = false
set.backup = false
set.undodir = os.getenv('HOME') .. '/.vim/undodir'
set.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
set.ignorecase = true
set.smartcase = true
set.incsearch = true

-- Keep signcolumn on by default
set.signcolumn = 'yes'

-- Decrease update time
set.updatetime = 250

-- Decrease mapped sequence wait time
set.timeoutlen = 300

-- Configure how new splits should be opened
set.splitright = true
set.splitbelow = true

-- Whitespace characters
--  See `:help 'list'` and `:help 'listchars'`
set.list = true
set.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
set.inccommand = 'split'

-- Show which line your cursor is on
set.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
set.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
set.confirm = true

-- vim: ts=2 sts=2 sw=2 et
