-- GitHub Copilot inline code suggestions and autocompletion.
-- NOTE: Only enable either copilot-vim or codeium-vim at the same time
-- To re-enable: remove `enabled = false`
return {
  {
    'github/copilot.vim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      -- enable copilot for specific filetypes
      vim.g.copilot_filetypes = {
        ['TelescopePrompt'] = false,
        ['markdown'] = true,
      }

      vim.g.copilot_assume_mapped = true
      vim.g.copilot_workspace_folders = '~/Projects'

      local keymap = vim.keymap.set
      local opts = { silent = true }

      keymap('i', '<C-y>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      keymap('i', '<C-j>', '<Plug>(copilot-next)', opts)
      keymap('i', '<C-k>', '<Plug>(copilot-previous)', opts)
      keymap('i', '<C-l>', '<Plug>(copilot-suggest)', opts)
      keymap('i', '<C-d>', '<Plug>(copilot-dismiss)', opts)
    end,
  },
}
