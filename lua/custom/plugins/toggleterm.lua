-- Toggleterm - persistent, named terminals with REPL support
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  opts = {
    size = 15,
    open_mapping = [[<C-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
    close_on_exit = true,
    shell = vim.o.shell,
  },
  keys = {
    -- Send visual selection to terminal (useful for Python REPL)
    {
      '<leader>ts',
      function()
        require('toggleterm').send_lines_to_terminal('visual_lines', true, { args = vim.v.count })
      end,
      mode = 'v',
      desc = '[T]erminal [S]end selection',
    },
    { '<leader>t1', '<cmd>1ToggleTerm<cr>', desc = '[T]erminal 1' },
    { '<leader>t2', '<cmd>2ToggleTerm<cr>', desc = '[T]erminal 2' },
    { '<leader>t3', '<cmd>3ToggleTerm<cr>', desc = '[T]erminal 3' },
  },
}
