-- Neogit: full git UI (status, commit, log, branches) inside Neovim.
-- Diffview: file diffing and file history, opened by Neogit and available standalone.
return {
  {
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
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gf', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diffview file history (current file)' },
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Diffview open' },
      { '<leader>ga', '<cmd>DiffviewClose<CR>', desc = 'Diffview close' },
    },
    opts = function()
      local actions = require('diffview.config').actions
      return {
        keymaps = {
          -- Mirror the global Neo-tree `\` toggle from inside Diffview's own buffers
          view = { ['\\'] = actions.toggle_files },
          file_panel = { ['\\'] = actions.toggle_files },
        },
      }
    end,
    config = function(_, opts)
      require('diffview').setup(opts)

      -- Diffview always opens in its own tabpage. If Neo-tree happens to have a window
      -- in that tab (e.g. from a global/persistent sidebar setup), close it so Diffview
      -- gets the full width, then bring it back once Diffview's tab is closed.
      local neotree_was_open = false
      local function neotree_is_open()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == 'neo-tree' then
            return true
          end
        end
        return false
      end

      local group = vim.api.nvim_create_augroup('diffview-neotree-sync', { clear = true })
      vim.api.nvim_create_autocmd('User', {
        desc = 'Close Neo-tree when Diffview opens',
        group = group,
        pattern = 'DiffviewViewOpened',
        callback = function()
          neotree_was_open = neotree_is_open()
          if neotree_was_open then
            vim.cmd 'Neotree close'
          end
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        desc = 'Reopen Neo-tree when Diffview closes',
        group = group,
        pattern = 'DiffviewViewClosed',
        callback = function()
          if neotree_was_open then
            vim.cmd 'Neotree show'
            neotree_was_open = false
          end
        end,
      })
    end,
  },
}
