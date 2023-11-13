local createautocommands = require('jaapied.core.autocommands')
local autocmds = {
  {
    event = 'FileType',
    pattern = 'html',
    callback = function()
      vim.opt.omnifunc = 'htmlcomplete#CompleteTags'
      vim.opt.formatoptions:remove('t')
    end
  }, {
    event = 'FileType',
    pattern = { 'css', 'scss' },
    callback = function() vim.opt.omnifunc = 'csscomplete#CompleteCSS' end
  }, {
    event = 'FileType',
    pattern = { 'yaml', 'python' },
    callback = function()
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
    end
  }, {
    event = 'FileType',
    pattern = 'apache',
    callback = function()
      vim.opt.comments = ':#'
      vim.opt.commentstring = '# %s'
    end
  }, {
    event = 'FileType',
    pattern = 'php',
    callback = function()
      vim.opt.commentstring = '// %s'
    end
  }, {
    event = 'BufReadPost',
    pattern = '*',
    callback = function()
    end
  }, {
    event = 'InsertEnter',
    pattern = { 'html', 'css', 'scss' },
    callback = function ()
      vim.opt.iskeyword:append('-')
    end
  }, {
    event = 'InsertLeave',
    pattern = { 'html', 'css', 'scss' },
    callback = function ()
      vim.opt.iskeyword:remove('-')
    end
  }
}

createautocommands(autocmds)
