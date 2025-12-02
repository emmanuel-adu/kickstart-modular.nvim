-- Hardtime.nvim - Break bad Vim habits by blocking repetitive motions
-- Encourages using efficient motions like w, b, }, { instead of jjjj or llll
return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  opts = {
    -- Beginner-friendly settings (not too strict)
    max_time = 1000, -- 1 second between repeated keys
    max_count = 4, -- Allow 4 repetitions before blocking (gentle start)
    disable_mouse = false, -- Still allow mouse (learn gradually)

    -- What keys to restrict
    restriction_mode = 'hint', -- Start with hints, not blocks
    restricted_keys = {
      -- Horizontal movement
      ['h'] = { 'n', 'x' },
      ['j'] = { 'n', 'x' },
      ['k'] = { 'n', 'x' },
      ['l'] = { 'n', 'x' },
      -- Arrow keys (discourage but don't block immediately)
      ['<Up>'] = { 'n', 'x' },
      ['<Down>'] = { 'n', 'x' },
      ['<Left>'] = { 'n', 'x' },
      ['<Right>'] = { 'n', 'x' },
    },

    -- Hints for better alternatives
    hint = true,
    notification = true,
    allow_different_key = true, -- Reset count if different key pressed

    -- File types where hardtime is disabled
    disabled_filetypes = {
      'qf',
      'netrw',
      'neo-tree',
      'lazy',
      'mason',
      'oil',
      'Trouble',
      'telescope',
      'TelescopePrompt',
      'TelescopeResults',
      'help',
      'startify',
      'Avante',
      'AvanteInput',
    },

    -- Suggest better motions
    hints = {
      ['k'] = {
        message = function(keys)
          return 'Use {, }, or ' .. keys .. 'k instead of repeating k'
        end,
        length = 4,
      },
      ['j'] = {
        message = function(keys)
          return 'Use {, }, or ' .. keys .. 'j instead of repeating j'
        end,
        length = 4,
      },
      ['l'] = {
        message = function(keys)
          return 'Use w, e, or ' .. keys .. 'l instead of repeating l'
        end,
        length = 4,
      },
      ['h'] = {
        message = function(keys)
          return 'Use b, or ' .. keys .. 'h instead of repeating h'
        end,
        length = 4,
      },
    },
  },
  config = function(_, opts)
    require('hardtime').setup(opts)

    -- Keybindings
    vim.keymap.set('n', '<leader>th', '<cmd>Hardtime toggle<cr>', { desc = '[T]oggle [H]ardtime' })
    vim.keymap.set('n', '<leader>hr', '<cmd>Hardtime report<cr>', { desc = '[H]ardtime [R]eport' })

    -- Helpful tip on startup
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.defer_fn(function()
          vim.notify(
            'Hardtime is active! Use <leader>th to toggle.\nIt will gently remind you to use better motions like w, b, {, }',
            vim.log.levels.INFO,
            { title = 'Learning Mode' }
          )
        end, 2000)
      end,
    })
  end,
}
