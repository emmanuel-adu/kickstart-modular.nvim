-- Terminal UI for Git operations - provides an interactive git interface within Neovim.
-- Requires: lazygit binary installed (brew install lazygit on macOS)
return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    { '<leader>gc', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit Current File' },
    { '<leader>gf', '<cmd>LazyGitFilter<cr>', desc = 'LazyGit Filter' },
  },
}
