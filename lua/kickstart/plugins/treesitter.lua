return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects', -- Code-aware text objects
    },
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'python', 'javascript', 'typescript', 'tsx', 'json', 'yaml' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      -- Incremental selection based on treesitter
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>', -- Start selection
          node_incremental = '<C-space>', -- Increment to next node
          scope_incremental = '<C-s>', -- Increment to scope
          node_decremental = '<C-backspace>', -- Decrement to previous node
        },
      },
      -- Textobjects: Code-aware selections and movements
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer', -- Select around function
            ['if'] = '@function.inner', -- Select inside function
            ['ac'] = '@class.outer', -- Select around class
            ['ic'] = '@class.inner', -- Select inside class
            ['aa'] = '@parameter.outer', -- Select around parameter/argument
            ['ia'] = '@parameter.inner', -- Select inside parameter/argument
            ['ai'] = '@conditional.outer', -- Select around if/else
            ['ii'] = '@conditional.inner', -- Select inside if/else
            ['al'] = '@loop.outer', -- Select around loop
            ['il'] = '@loop.inner', -- Select inside loop
            ['ab'] = '@block.outer', -- Select around block
            ['ib'] = '@block.inner', -- Select inside block
            ['a/'] = '@comment.outer', -- Select around comment
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>sn'] = '@parameter.inner', -- Swap parameter with next
          },
          swap_previous = {
            ['<leader>sp'] = '@parameter.inner', -- Swap parameter with previous
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Add jumps to jumplist
          goto_next_start = {
            [']f'] = '@function.outer', -- Next function start
            [']c'] = '@class.outer', -- Next class start
            [']a'] = '@parameter.inner', -- Next parameter
            [']i'] = '@conditional.outer', -- Next conditional
            [']l'] = '@loop.outer', -- Next loop
          },
          goto_next_end = {
            [']F'] = '@function.outer', -- Next function end
            [']C'] = '@class.outer', -- Next class end
            [']A'] = '@parameter.inner', -- Next parameter end
          },
          goto_previous_start = {
            ['[f'] = '@function.outer', -- Previous function start
            ['[c'] = '@class.outer', -- Previous class start
            ['[a'] = '@parameter.inner', -- Previous parameter
            ['[i'] = '@conditional.outer', -- Previous conditional
            ['[l'] = '@loop.outer', -- Previous loop
          },
          goto_previous_end = {
            ['[F'] = '@function.outer', -- Previous function end
            ['[C'] = '@class.outer', -- Previous class end
            ['[A'] = '@parameter.inner', -- Previous parameter end
          },
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
