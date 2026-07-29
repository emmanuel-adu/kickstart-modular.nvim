-- Neogit: full git UI (status, commit, log, branches) inside Neovim.
return {
  'NeogitOrg/neogit',
  dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
  keys = { { '<leader>gg', function() require('neogit').open() end, desc = 'Neogit' } },
  config = function(_, opts)
    require('neogit').setup(opts)

    -- Keep Neo-tree's filesystem/git_status views in sync with git operations done in Neogit
    vim.api.nvim_create_autocmd('User', {
      desc = 'Refresh Neo-tree after Neogit changes the git state',
      group = vim.api.nvim_create_augroup('neogit-neotree-sync', { clear = true }),
      pattern = 'NeogitStatusRefreshed',
      callback = function()
        local ok, manager = pcall(require, 'neo-tree.sources.manager')
        if not ok then
          return
        end
        manager.refresh 'git_status'
        manager.refresh 'filesystem'
      end,
    })
  end,
}
