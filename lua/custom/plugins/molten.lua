-- Molten.nvim - Interactive Jupyter notebooks in Neovim
-- Requires: jupyter, ipython, pynvim
-- Install: pip install jupyter ipython pynvim cairosvg plotly kaleido pnglatex pyperclip
return {
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    dependencies = { '3rd/image.nvim' },
    build = ':UpdateRemotePlugins',
    init = function()
      -- Configuration options
      vim.g.molten_image_provider = 'image.nvim'
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_output_show_more = true
      vim.g.molten_output_win_border = { '', '━', '', '' }
      vim.g.molten_output_win_cover_gutter = true
      vim.g.molten_auto_image_popup = true
      vim.g.molten_enter_output_behavior = 'open_then_enter'
      vim.g.molten_use_border_highlights = true
      vim.g.molten_limit_output_chars = 1000000
      vim.g.molten_tick_rate = 500
      vim.g.molten_image_location = 'float'
      vim.g.molten_split_direction = 'right'
      vim.g.molten_split_size = 40
    end,
    keys = {
      -- Initialize kernel
      { '<leader>mi', ':MoltenInit<CR>', desc = '[M]olten [I]nit Kernel', silent = true },
      { '<leader>mI', ':MoltenInfo<CR>', desc = '[M]olten [I]nfo', silent = true },

      -- Evaluate cells
      { '<leader>me', ':MoltenEvaluateLine<CR>', desc = '[M]olten [E]val Line', silent = true },
      { '<leader>me', ':<C-u>MoltenEvaluateVisual<CR>gv', mode = 'v', desc = '[M]olten [E]val Visual', silent = true },
      { '<leader>mr', ':MoltenReevaluateCell<CR>', desc = '[M]olten [R]e-eval Cell', silent = true },
      { '<leader>mc', ':MoltenEvaluateOperator<CR>', desc = '[M]olten Eval Operator', silent = true },

      -- Navigate cells
      { '[c', ':MoltenPrev<CR>', desc = 'Molten Prev Cell', silent = true },
      { ']c', ':MoltenNext<CR>', desc = 'Molten Next Cell', silent = true },

      -- Output management
      { '<leader>mo', ':MoltenShowOutput<CR>', desc = '[M]olten Show [O]utput', silent = true },
      { '<leader>mh', ':MoltenHideOutput<CR>', desc = '[M]olten [H]ide Output', silent = true },
      { '<leader>md', ':MoltenDelete<CR>', desc = '[M]olten [D]elete Cell', silent = true },

      -- Kernel management
      { '<leader>mx', ':MoltenInterrupt<CR>', desc = '[M]olten Interrupt Kernel', silent = true },
      { '<leader>mX', ':MoltenRestart!<CR>', desc = '[M]olten Restart Kernel', silent = true },
      { '<leader>mq', ':MoltenDeinit<CR>', desc = '[M]olten Quit Kernel', silent = true },

      -- Import/Export
      { '<leader>ms', ':MoltenSave<CR>', desc = '[M]olten [S]ave', silent = true },
      { '<leader>ml', ':MoltenLoad<CR>', desc = '[M]olten [L]oad', silent = true },
      { '<leader>mE', ':MoltenExportOutput<CR>', desc = '[M]olten [E]xport Output', silent = true },
    },
  },
  {
    '3rd/image.nvim',
    opts = {
      backend = 'kitty', -- Works with Kitty, Ghostty, WezTerm (Kitty graphics protocol)
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'markdown', 'vimwiki', 'quarto' },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'norg' },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.svg' },
    },
  },
  {
    -- Quarto support (optional - for .qmd files)
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { 'python', 'r', 'julia' },
        chunks = 'all',
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = false, -- Use molten keymaps instead
    },
    dependencies = {
      'jmbuhr/otter.nvim',
    },
  },
}
