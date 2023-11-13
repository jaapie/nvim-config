local pinnacle = require('wincent.pinnacle')
local createautocommands = require('jaapied.core.autocommands')

local function fileencoding()
  local fileencoding = vim.bo.fileencoding
  if #fileencoding > 0 and fileencoding ~= 'utf-8' then
    return ',' .. fileencoding
  else
    return ''
  end
end

-- Returns relative path to current file's directory.
local function fileprefix()
  local basename = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':p:~:.')
  if basename == '' or basename == '.' then
    return ''
  else
    return basename:gsub('/$', '') .. '/'
  end
end

-- Returns the 'filetype' (not using the %Y format because I don't want caps).
local function filetype()
  local filetype = vim.bo.filetype
  if #filetype > 0 then
    return filetype
  else
    return ''
  end
end

local function buffermodified()
  -- local buf = vim.api.nvim_get_current_buf()
  -- local buf_modified  = vim.api.nvim_buf_get_option(buf, 'modified')
  if vim.bo.modified then
    return ',+'
  else
    return ''
  end
end

local function gutterpadding()
  local signcolumn = 0
  local option = vim.wo.signcolumn
  if option == 'yes' then
    signcolumn = 2
  elseif option == 'auto' then
    local signs = vim.fn.sign_getplaced('')
    if #signs[1].signs > 0 then
      signcolumn = 2
    end
  end

  local minwidth = 2
  local numberwidth = vim.wo.numberwidth
  local row = vim.api.nvim_buf_line_count(0)
  local gutterwidth = math.max((#tostring(row) + 1), minwidth, numberwidth) + signcolumn
  local padding = (' '):rep(gutterwidth - 1)
  return padding
end

local function update_highlight()
  -- Update StatusLine to use italics (used for filetype).
  pinnacle.set('User1', pinnacle.italicize('StatusLine'))

  -- StatusLine + bold (used for file names).
  pinnacle.set('User3', pinnacle.embolden('StatusLine'))

  local lhs_fg = pinnacle.fg('Title')
  local lhs_bg = pinnacle.bg('StatusLine')
  pinnacle.set('User4', { bg = lhs_bg, fg = lhs_fg })

  pinnacle.set('User7', {
    bg = lhs_fg,
    -- fg = pinnacle.fg('Error'),
    fg = lhs_bg,
    bold = true,
  })

  -- Right-hand side section.
  rhs_bg = pinnacle.fg('Cursor')
  rhs_fg = pinnacle.fg('User3')
  pinnacle.set('User5', {
    bg = rhs_fg,
    fg = rhs_bg,
    bold = true,
  })

  local darker = pinnacle.darken('StatusLine', 0.15)
  pinnacle.set('User2', {
    bg = darker['fg'],
    fg = darker['bg']
  })

  pinnacle.set('User6', {
    bg = darker['bg'],
    fg = darker['fg']
  })
  
  pinnacle.set('User9', darker)

  pinnacle.link('StatusLineNC', 'User1')
end

local function bufferinfo()
  if vim.api.nvim_buf_get_name(0) == '' then
    return ''
  else
    return '[' .. filetype() .. fileencoding() .. buffermodified() .. ']'
  end
end

local function staticky_mess()
  local staticky_chars = "▀▁▂▃▄▅▆▇█▉▊▋▌▍▎▏▐▔▕▖▗▘▙▚▛▜▝▞▟"
  local mess = ""
  for i = 1,8 do
    local index = math.random(1, #staticky_chars)
    mess = mess .. staticky_chars:sub(index, index)
  end
  return mess
end

local function set_active_statusline()
  update_highlight()
  vim.opt_local.statusline = '%7*'                         -- Switch to User7 highlight group
    .. gutterpadding()
    .. '%n'                         -- Buffer number.
    .. ' '                          -- Space.
    .. '%*'                         -- Reset highlight group.
    .. '%4*'                        -- Switch to User4 highlight group (Powerline arrow).
    .. '▚▀▎▖▔'                          -- Powerline arrow.
    .. '%*'                         -- Reset highlight group.
    .. ' '                          -- Space.
    .. '%<'                         -- Truncation point, if not enough width available.
    .. fileprefix()                 -- Relative path to file's directory.
    .. '%3*'                        -- Switch to User3 highlight group (bold).
    .. '%t'                         -- Filename.
    .. '%*'                         -- Reset highlight group.
    .. ' '                          -- Space.
    .. '%1*'                        -- Switch to User1 highlight group (italics).
    .. '%('
    .. bufferinfo()
    .. '%)'
    .. '%*'   -- Reset highlight group.
    .. '%='   -- Split point for left and right groups.
    .. '▁▀▙▚'                          -- Powerline arrow.
    .. '%5*'  -- Switch to User5 highlight group.
    .. ' '    -- Space.
    .. '%p'   -- Percentage through buffer.
    .. '%%'   -- Literal %.
    .. '   '    -- Space.
    .. '%*'   -- Reset highlight group.
end

local function set_inactive_statusline()
  update_highlight()
  vim.opt_local.statusline = '%2*'                         -- Switch to User7 highlight group
    .. gutterpadding()
    .. '%n'                         -- Buffer number.
    .. ' '                          -- Space.
    .. '%*'                         -- Reset highlight group.
    .. '%6*'                        -- Switch to User4 highlight group (Powerline arrow).
    .. '▚▀▎▖▔'                          -- Powerline arrow.
    .. '%*'                         -- Reset highlight group.
    .. '%9*'                        -- Switch to User4 highlight group (Powerline arrow).
    .. ' '                          -- Space.
    .. '%<'                         -- Truncation point, if not enough width available.
    .. fileprefix()                 -- Relative path to file's directory.
    .. '%t'                         -- Filename.
    .. ' '                          -- Space.
    .. '%('
    .. bufferinfo()
    .. '%)'
    .. '%='   -- Split point for left and right groups.
    .. '%*'                         -- Reset highlight group.
    .. '%6*'                        -- Switch to User1 highlight group (italics).
    .. '▁▀▙▚'                          -- Powerline arrow.
    .. '%*'   -- Reset highlight group.
    .. '%2*'  -- Switch to User5 highlight group.
    .. '   '    -- Space.
    .. '%*'   -- Reset highlight group.
end

local autocommands = {
  {
    event = 'ColorScheme',
    pattern = '*',
    callback = function()
      update_highlight()
    end
  }, {
    event = {'BufWritePost','FileWritePost','TextChanged','TextChangedI'},
    pattern = '*',
    callback = set_active_statusline
  }, {
    event = {'BufWinEnter','BufEnter','WinEnter'},
    pattern = '*',
    callback = set_active_statusline
  }, {
    event = {'BufLeave','WinLeave'},
    pattern = '*',
    callback = set_inactive_statusline
  }
}

createautocommands(autocommands)
