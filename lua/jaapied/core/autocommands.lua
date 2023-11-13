local create_auto_commands = function(autocmds)
  for _, autocmd in ipairs(autocmds) do
    vim.api.nvim_create_autocmd(
      autocmd.event,
      {
        pattern = autocmd.pattern,
        command = autocmd.command,
        callback = autocmd.callback
      }
    )
  end
end

return create_auto_commands
