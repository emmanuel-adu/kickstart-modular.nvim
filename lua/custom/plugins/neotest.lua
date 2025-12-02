-- Neotest - Modern testing framework for Neovim
-- Requires test frameworks: pytest (Python), go test (Go), jest (JS/TS)
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- Language adapters
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          args = { '--log-level', 'DEBUG', '-vv' },
          runner = 'pytest',
        },
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = { '-v', '-race', '-count=1' },
        },
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.js',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
      discovery = {
        enabled = true,
        concurrent = 1,
      },
      running = {
        concurrent = true,
      },
      summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
      },
      output = {
        enabled = true,
        open_on_run = 'short',
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      status = {
        enabled = true,
        signs = true,
        virtual_text = true,
      },
      icons = {
        running_animated = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
        passed = '',
        running = '',
        failed = '',
        skipped = '',
        unknown = '',
        watching = '',
      },
    }

    -- Keymaps
    local neotest = require 'neotest'
    vim.keymap.set('n', '<leader>tt', function()
      neotest.run.run()
    end, { desc = '[T]est Run Nearest' })
    vim.keymap.set('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = '[T]est Run [F]ile' })
    vim.keymap.set('n', '<leader>td', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = '[T]est [D]ebug Nearest' })
    vim.keymap.set('n', '<leader>ts', function()
      neotest.summary.toggle()
    end, { desc = '[T]est [S]ummary Toggle' })
    vim.keymap.set('n', '<leader>to', function()
      neotest.output.open { enter = true, auto_close = true }
    end, { desc = '[T]est [O]utput' })
    vim.keymap.set('n', '<leader>tO', function()
      neotest.output_panel.toggle()
    end, { desc = '[T]est [O]utput Panel' })
    vim.keymap.set('n', '<leader>tS', function()
      neotest.run.stop()
    end, { desc = '[T]est [S]top' })
    vim.keymap.set('n', '<leader>tw', function()
      neotest.watch.toggle()
    end, { desc = '[T]est [W]atch' })
  end,
}
