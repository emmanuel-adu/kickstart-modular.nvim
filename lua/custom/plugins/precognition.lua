-- Precognition.nvim - Real-time motion hints for learning Vim
-- Shows available motions as you navigate, teaching you efficient movement
return {
  'tris203/precognition.nvim',
  event = 'VeryLazy',
  opts = {
    startVisible = true, -- Show hints immediately
    showBlankVirtLine = true, -- Show hints even on blank lines
    highlightColor = { link = 'Comment' }, -- Subtle gray hints
    hints = {
      Caret = { text = '^', prio = 2 }, -- First non-blank character
      Dollar = { text = '$', prio = 1 }, -- End of line
      MatchingPair = { text = '%', prio = 5 }, -- Matching bracket
      Zero = { text = '0', prio = 1 }, -- Start of line
      w = { text = 'w', prio = 10 }, -- Next word start
      b = { text = 'b', prio = 9 }, -- Previous word start
      e = { text = 'e', prio = 8 }, -- End of word
      W = { text = 'W', prio = 7 }, -- Next WORD (whitespace separated)
      B = { text = 'B', prio = 7 }, -- Previous WORD
      E = { text = 'E', prio = 7 }, -- End of WORD
    },
    gutterHints = {
      -- Show paragraph and line number jumps in gutter
      G = { text = 'G', prio = 10 }, -- Go to line
      gg = { text = 'gg', prio = 9 }, -- First line
      PrevParagraph = { text = '{', prio = 8 }, -- Previous paragraph
      NextParagraph = { text = '}', prio = 8 }, -- Next paragraph
    },
    disabled_fts = {
      -- Don't show in these file types
      'startify',
      'neo-tree',
      'Trouble',
      'lazy',
      'mason',
      'telescope',
      'TelescopePrompt',
      'TelescopeResults',
      'Avante',
      'AvanteInput',
    },
  },
  config = function(_, opts)
    require('precognition').setup(opts)

    -- Keybindings to toggle on/off
    vim.keymap.set('n', '<leader>tp', function()
      require('precognition').toggle()
    end, { desc = '[T]oggle [P]recognition Hints' })

    -- Peek at available motions (useful when learning)
    vim.keymap.set('n', '<leader>pp', function()
      require('precognition').peek()
    end, { desc = '[P]recognition [P]eek' })
  end,
}
