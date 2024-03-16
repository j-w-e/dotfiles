require('which-key').register({
  ['<m-i>'] = { require('remaps').insert_r_chunk, 'r code chunk' },
  ['<cm-i>'] = { require('remaps').insert_py_chunk, 'python code chunk' },
  ['<m-I>'] = { require('remaps').insert_py_chunk, 'python code chunk' },
}, { mode = 'n', silent = true, buffer = 0 })
