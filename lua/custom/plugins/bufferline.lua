-- Bufferline - display open buffers as tabs with pin support
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      offsets = {
        { filetype = 'neo-tree', text = 'File Explorer', highlight = 'Directory', text_align = 'left' },
      },
    },
  },
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = '[B]uffer [P]in toggle' },
    { '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = '[B]uffer close un[P]inned' },
    { '<leader>bd', '<cmd>bdelete<cr>', desc = '[B]uffer [D]elete' },
  },
}
