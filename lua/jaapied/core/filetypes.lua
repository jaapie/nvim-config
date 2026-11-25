-- Extra filetype detection beyond what Neovim ships

-- ngspice / SPICE netlists. Neovim already maps *.sp and *.spice.
vim.filetype.add({
  extension = {
    cir = 'spice',
    ckt = 'spice',
    net = 'spice',
  },
  filename = {
    ['.spiceinit'] = 'spice',
    ['spinit'] = 'spice',
  },
})
