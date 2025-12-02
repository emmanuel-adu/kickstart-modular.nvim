-- Avante.nvim - Multi-provider AI integration (Cursor-like experience)
-- Supports: Claude (Anthropic), OpenAI, Azure, Gemini, and more
-- API Keys: Set AVANTE_ANTHROPIC_API_KEY and/or AVANTE_OPENAI_API_KEY
-- Or use: ANTHROPIC_API_KEY, OPENAI_API_KEY (legacy)
return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false,
  opts = {
    provider = 'claude', -- Default provider: 'claude' or 'openai'
    auto_suggestions_provider = 'claude',
    providers = {
      claude = {
        endpoint = 'https://api.anthropic.com',
        model = 'claude-sonnet-4-20250514',
        ['local'] = false,
        extra_request_body = {
          max_tokens = 4096,
          temperature = 0,
        },
      },
      openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o',
        ['local'] = false,
        extra_request_body = {
          max_tokens = 4096,
          temperature = 0,
        },
      },
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },
    mappings = {
      --- @class AvanteConflictMappings
      diff = {
        ours = 'co',
        theirs = 'ct',
        all_theirs = 'ca',
        both = 'cb',
        cursor = 'cc',
        next = ']x',
        prev = '[x',
      },
      suggestion = {
        accept = '<M-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
      jump = {
        next = ']]',
        prev = '[[',
      },
      submit = {
        normal = '<CR>',
        insert = '<C-s>',
      },
      sidebar = {
        apply_all = 'A',
        apply_cursor = 'a',
        switch_windows = '<Tab>',
        reverse_switch_windows = '<S-Tab>',
      },
    },
    hints = { enabled = true },
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = 'right',
      wrap = true,
      width = 30,
      sidebar_header = {
        enabled = true,
        align = 'center',
        rounded = true,
      },
    },
    highlights = {
      ---@type AvanteConflictHighlights
      diff = {
        current = 'DiffText',
        incoming = 'DiffAdd',
      },
    },
  },
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- Optional dependencies
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
  config = function(_, opts)
    require('avante').setup(opts)

    -- Custom keymaps
    vim.keymap.set('n', '<leader>aa', '<cmd>AvanteToggle<cr>', { desc = '[A]vante Toggle' })
    vim.keymap.set('n', '<leader>ar', '<cmd>AvanteRefresh<cr>', { desc = '[A]vante [R]efresh' })
    vim.keymap.set('v', '<leader>ae', '<cmd>AvanteAsk<cr>', { desc = '[A]vante [E]dit Selection' })
    vim.keymap.set('n', '<leader>ac', '<cmd>AvanteClear<cr>', { desc = '[A]vante [C]lear' })
    vim.keymap.set('n', '<leader>as', '<cmd>AvanteSwitchProvider<cr>', { desc = '[A]vante [S]witch Provider' })
  end,
}
