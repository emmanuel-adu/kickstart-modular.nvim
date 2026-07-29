-- Neogit: full git UI (status, commit, log, branches) inside Neovim.
return {
  'NeogitOrg/neogit',
  dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
  keys = { { '<leader>gg', function() require('neogit').open() end, desc = 'Neogit' } },
}
