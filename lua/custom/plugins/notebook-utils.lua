-- Notebook utilities and enhancements
return {
  {
    -- Jupytext for editing notebooks as Python files
    'GCBallesteros/jupytext.nvim',
    config = function()
      require('jupytext').setup {
        style = 'markdown',
        output_extension = 'md',
        force_ft = 'markdown',
        custom_language_formatting = {
          python = {
            extension = 'py',
            style = 'light',
            force_ft = 'python',
          },
          r = {
            extension = 'r',
            style = 'light',
            force_ft = 'r',
          },
        },
      }
    end,
  },
}
