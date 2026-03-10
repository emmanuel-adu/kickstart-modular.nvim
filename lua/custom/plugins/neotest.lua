-- Neotest - Modern testing framework for Neovim
-- Requires test frameworks: pytest (Python), go test (Go), vitest (JS/TS)
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
    'marilari88/neotest-vitest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false },
          -- Pytest arguments (can be overridden per-run)
          args = { '-v' }, -- Verbose output, remove DEBUG logs for cleaner output
          runner = 'pytest',
          -- Python executable (uses system python by default)
          -- python = '/usr/bin/python3',
          -- Find pytest.ini, pyproject.toml, setup.cfg, or tox.ini in project root
          pytest_discover_nearest = true,
          -- Use pytest's default test discovery patterns
          -- This helps find tests even if they're not in standard locations
        },
        require 'neotest-go' {
          experimental = {
            test_table = true,
          },
          args = { '-v', '-race', '-count=1' },
        },
        require 'neotest-vitest' {
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        },
      },
      discovery = {
        enabled = true,
        concurrent = 1,
      },
      running = {
        concurrent = true,
        -- Add timeout to prevent hanging
        timeout = 10000, -- 10 seconds
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
    
    -- Run nearest test (test under cursor)
    vim.keymap.set('n', '<leader>tt', function()
      local ok, err = pcall(function()
        neotest.run.run()
      end)
      
      if not ok then
        vim.notify(
          'Error running test: ' .. tostring(err) .. '\n' ..
          'Make sure you are in a test file with a test function',
          vim.log.levels.ERROR,
          { timeout = 5000 }
        )
      end
    end, { desc = '[T]est Run Nearest' })
    
    -- Run all tests in current file (pytest file.py)
    vim.keymap.set('n', '<leader>tf', function()
      local file = vim.fn.expand '%'
      if file == '' then
        vim.notify('No file to run', vim.log.levels.ERROR)
        return
      end
      
      -- Check if file is a test file
      local filename = vim.fn.fnamemodify(file, ':t')
      local is_test_file = filename:match('^test_.*%.py$') or filename:match('.*_test%.py$')
      
      if not is_test_file then
        vim.notify(
          'Not a test file: ' .. filename .. '\n' ..
          'Test files must start with "test_" or end with "_test.py"\n' ..
          'Use <leader>tP to run pytest directly on any file',
          vim.log.levels.WARN,
          { timeout = 5000 }
        )
        return
      end
      
      -- Run with explicit file path and ensure pytest can find it
      local ok, err = pcall(function()
        neotest.run.run(file, {
          extra_args = { '--tb=short' }, -- Shorter traceback format
        })
      end)
      
      if not ok then
        vim.notify(
          'Error running tests: ' .. tostring(err) .. '\n' ..
          'Try: <leader>tP to run pytest directly',
          vim.log.levels.ERROR,
          { timeout = 5000 }
        )
      end
    end, { desc = '[T]est Run [F]ile' })
    
    -- Run current file with verbose output
    vim.keymap.set('n', '<leader>tF', function()
      local file = vim.fn.expand '%'
      if file == '' then
        vim.notify('No file to run', vim.log.levels.ERROR)
        return
      end
      
      local filename = vim.fn.fnamemodify(file, ':t')
      local is_test_file = filename:match('^test_.*%.py$') or filename:match('.*_test%.py$')
      
      if not is_test_file then
        vim.notify('Not a test file: ' .. filename, vim.log.levels.WARN)
        return
      end
      
      local ok, err = pcall(function()
        neotest.run.run(file, { extra_args = { '-vv' } })
      end)
      
      if not ok then
        vim.notify('Error: ' .. tostring(err), vim.log.levels.ERROR)
      end
    end, { desc = '[T]est Run [F]ile Verbose' })
    
    -- Run pytest directly in terminal (bypasses neotest UI)
    vim.keymap.set('n', '<leader>tP', function()
      local file = vim.fn.expand '%'
      if file == '' then
        vim.notify('No file to run', vim.log.levels.ERROR)
        return
      end
      -- Change to file's directory to ensure pytest can find tests
      local dir = vim.fn.fnamemodify(file, ':h')
      vim.cmd('cd ' .. vim.fn.fnameescape(dir))
      vim.cmd('terminal pytest ' .. vim.fn.shellescape(file) .. ' -v')
    end, { desc = '[T]est [P]ytest Direct (terminal)' })
    
    -- Debug: Show test discovery help
    vim.keymap.set('n', '<leader>t?', function()
      local file = vim.fn.expand '%'
      local filename = file ~= '' and vim.fn.fnamemodify(file, ':t') or 'No file'
      local is_test_file = filename:match('^test_.*%.py$') or filename:match('.*_test%.py$')
      
      local help_msg = {
        'Test Discovery Debug:',
        '',
        'Current file: ' .. (file ~= '' and file or 'No file'),
        'Filename: ' .. filename,
        'Is test file: ' .. (is_test_file and '✅ Yes' or '❌ No'),
        '',
      }
      
      if not is_test_file and file ~= '' then
        table.insert(help_msg, '⚠️  This is NOT a test file!')
        table.insert(help_msg, '')
        table.insert(help_msg, 'To run tests:')
        table.insert(help_msg, '1. Create a test file: test_' .. filename)
        table.insert(help_msg, '   OR rename to: ' .. filename:gsub('%.py$', '_test.py'))
        table.insert(help_msg, '2. Use <leader>tP to run pytest on any file')
        table.insert(help_msg, '3. Use <leader>ts to see all discovered tests')
      else
        table.insert(help_msg, 'Common issues:')
        table.insert(help_msg, '1. Test functions must start with test_')
        table.insert(help_msg, '2. Check if pytest can find tests:')
        table.insert(help_msg, '   :terminal pytest ' .. filename)
        table.insert(help_msg, '3. Open test summary: <leader>ts')
        table.insert(help_msg, '4. Check pytest config: pytest.ini or pyproject.toml')
      end
      
      vim.notify(table.concat(help_msg, '\n'), vim.log.levels.INFO, { timeout = 10000 })
    end, { desc = '[T]est Debug - Show test discovery help' })
    
    -- Debug nearest test
    vim.keymap.set('n', '<leader>td', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = '[T]est [D]ebug Nearest' })
    
    -- Toggle test summary window
    vim.keymap.set('n', '<leader>ts', function()
      neotest.summary.toggle()
    end, { desc = '[T]est [S]ummary Toggle' })
    
    -- Open test output
    vim.keymap.set('n', '<leader>to', function()
      neotest.output.open { enter = true, auto_close = true }
    end, { desc = '[T]est [O]utput' })
    
    -- Toggle output panel
    vim.keymap.set('n', '<leader>tO', function()
      neotest.output_panel.toggle()
    end, { desc = '[T]est [O]utput Panel' })
    
    -- Stop running tests
    vim.keymap.set('n', '<leader>tS', function()
      neotest.run.stop()
    end, { desc = '[T]est [S]top' })
    
    -- Toggle watch mode
    vim.keymap.set('n', '<leader>tw', function()
      neotest.watch.toggle()
    end, { desc = '[T]est [W]atch' })
    
    -- Find and run related test file (if current file is not a test file)
    vim.keymap.set('n', '<leader>tr', function()
      local file = vim.fn.expand '%'
      if file == '' then
        vim.notify('No file open', vim.log.levels.ERROR)
        return
      end
      
      local filename = vim.fn.fnamemodify(file, ':t')
      local dir = vim.fn.fnamemodify(file, ':h')
      local basename = vim.fn.fnamemodify(file, ':t:r')
      
      -- Check if already a test file
      local is_test_file = filename:match('^test_.*%.py$') or filename:match('.*_test%.py$')
      if is_test_file then
        vim.notify('Already in a test file. Use <leader>tf to run tests.', vim.log.levels.INFO)
        return
      end
      
      -- Try to find related test file
      local test_file_patterns = {
        dir .. '/test_' .. basename .. '.py',
        dir .. '/' .. basename .. '_test.py',
        dir .. '/tests/test_' .. basename .. '.py',
        dir .. '/tests/' .. basename .. '_test.py',
        dir .. '/../tests/test_' .. basename .. '.py',
      }
      
      local found_test = nil
      for _, pattern in ipairs(test_file_patterns) do
        if vim.fn.filereadable(pattern) == 1 then
          found_test = pattern
          break
        end
      end
      
      if found_test then
        vim.notify('Found test file: ' .. vim.fn.fnamemodify(found_test, ':t'), vim.log.levels.INFO)
        local ok, err = pcall(function()
          neotest.run.run(found_test, { extra_args = { '--tb=short' } })
        end)
        if not ok then
          vim.notify('Error: ' .. tostring(err), vim.log.levels.ERROR)
        end
      else
        vim.notify(
          'No related test file found for: ' .. filename .. '\n' ..
          'Expected: test_' .. basename .. '.py or ' .. basename .. '_test.py',
          vim.log.levels.WARN,
          { timeout = 5000 }
        )
      end
    end, { desc = '[T]est Run [R]elated test file' })
  end,
}
