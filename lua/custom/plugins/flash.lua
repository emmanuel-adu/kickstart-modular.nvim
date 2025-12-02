-- Flash.nvim - Enhanced navigation with labeled jumps
-- Jump anywhere on screen with 2-3 keystrokes using visual labels
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    -- Label configuration
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    search = {
      multi_window = true, -- Search across all visible windows
      forward = true, -- Search forward by default
      wrap = true, -- Wrap around at end of buffer
      mode = 'exact', -- Exact match mode
      incremental = false, -- Don't show labels while typing
    },
    jump = {
      jumplist = true, -- Add jumps to jumplist (CTRL-O to go back)
      pos = 'start', -- Jump to start of match
      history = false, -- Don't remember previous searches
      register = false, -- Don't save to register
      nohlsearch = false, -- Keep search highlighting
      autojump = false, -- Don't auto-jump if only one match
    },
    label = {
      uppercase = true, -- Use uppercase labels for better visibility
      exclude = '', -- No excluded labels
      current = true, -- Show label for current match
      after = true, -- Show label after match
      before = false, -- Don't show label before match
      style = 'overlay', -- Overlay labels on text
      reuse = 'lowercase', -- Reuse lowercase for next jump
      distance = true, -- Sort labels by distance
    },
    highlight = {
      backdrop = true, -- Dim the backdrop
      matches = true, -- Highlight all matches
      priority = 5000, -- High priority
      groups = {
        match = 'FlashMatch', -- Highlight group for matches
        current = 'FlashCurrent', -- Current match
        backdrop = 'FlashBackdrop', -- Dimmed text
        label = 'FlashLabel', -- Jump labels
      },
    },
    modes = {
      -- Standard search mode
      search = {
        enabled = true,
        highlight = { backdrop = false },
        jump = { history = true, register = true, nohlsearch = true },
      },
      -- Character-based search
      char = {
        enabled = true,
        -- Configuration for f, F, t, T motions
        keys = { 'f', 'F', 't', 'T' },
        search = { wrap = false },
        highlight = { backdrop = true },
        jump = { register = false },
        multi_line = true,
        label = { exclude = 'hjkliardc' }, -- Exclude common motion keys
        jump_labels = true, -- Show labels for multiple matches
      },
      -- Treesitter mode (for selecting text objects)
      treesitter = {
        labels = 'abcdefghijklmnopqrstuvwxyz',
        jump = { pos = 'range' },
        search = { incremental = false },
        label = { before = true, after = true, style = 'inline' },
        highlight = {
          backdrop = false,
          matches = false,
        },
      },
    },
    -- Prompt configuration
    prompt = {
      enabled = true,
      prefix = { { '⚡', 'FlashPromptIcon' } },
      win_config = {
        relative = 'editor',
        width = 1,
        height = 1,
        row = -1,
        col = 0,
        zindex = 1000,
      },
    },
  },
  keys = {
    -- Primary jump motion (s = search 2 characters)
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash Jump',
    },
    -- Treesitter search (S = select code structures)
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    -- Remote operation (use Flash labels with operators)
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    -- Treesitter search for visual selections
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    -- Toggle Flash search in regular search
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
  config = function(_, opts)
    require('flash').setup(opts)

    -- Custom highlights for better visibility
    vim.api.nvim_set_hl(0, 'FlashLabel', {
      fg = '#ff007c',
      bold = true,
      bg = '#000000',
    })

    vim.api.nvim_set_hl(0, 'FlashMatch', {
      fg = '#ffffff',
      bg = '#3e4451',
    })

    vim.api.nvim_set_hl(0, 'FlashCurrent', {
      fg = '#000000',
      bg = '#ff007c',
      bold = true,
    })

    -- Help message on first use
    local flash_help_shown = false
    vim.api.nvim_create_autocmd('User', {
      pattern = 'FlashEnter',
      callback = function()
        if not flash_help_shown then
          flash_help_shown = true
          vim.notify(
            "Flash Navigation Tips:\n• 's' + 2 chars = jump anywhere\n• 'S' = select function/class\n• Use with operators: 'd', 'c', 'y'\n• Example: ds{chars} = delete to match",
            vim.log.levels.INFO,
            { title = 'Flash.nvim' }
          )
        end
      end,
    })
  end,
}
