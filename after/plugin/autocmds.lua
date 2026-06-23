local createautocommands = require('jaapied.core.autocommands')
local autocmds = {
  {
    event = 'FileType',
    pattern = 'html',
    callback = function()
      vim.opt_local.omnifunc = 'htmlcomplete#CompleteTags'
      vim.opt_local.formatoptions:remove('t')
    end
  }, {
    event = 'FileType',
    pattern = { 'css', 'scss' },
    callback = function() vim.opt_local.omnifunc = 'csscomplete#CompleteCSS' end
  }, {
    event = 'FileType',
    pattern = { 'yaml', 'python' },
    callback = function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true
    end
  }, {
    event = 'FileType',
    pattern = 'apache',
    callback = function()
      vim.opt_local.comments = ':#'
      vim.opt_local.commentstring = '# %s'
    end
  }, {
    event = 'FileType',
    pattern = 'php',
    callback = function()
      vim.opt_local.commentstring = '// %s'
    end
  }, {
    event = 'InsertEnter',
    pattern = { '*.html', '*.css', '*.scss' },
    callback = function ()
      vim.opt_local.iskeyword:append('-')
    end
  }, {
    event = 'InsertLeave',
    pattern = { '*.html', '*.css', '*.scss' },
    callback = function ()
      vim.opt_local.iskeyword:remove('-')
    end
  }
}

createautocommands(autocmds)
