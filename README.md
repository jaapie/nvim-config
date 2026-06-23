# nvim-config

Personal Neovim configuration, evolved from my old [Vim dotfiles](https://github.com/jaapie/dotfiles). Written in Lua, structured under the `jaapied` namespace, and managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Features

- **LSP** via nvim-lspconfig: ruby-lsp (with RuboCop + Rails), stimulus-ls, html, and Sorbet (auto-enabled when `sorbet/config` is present)
- **Completion** via nvim-cmp
- **Formatting/linting** via none-ls: stylua, erb-lint
- **Fuzzy finding** via Telescope (files, buffers, live grep)
- **File explorer** via oil.nvim (`-` to open from any buffer)
- **Ruby/Rails**: vim-ruby, vim-rails, vim-rspec, vim-endwise, vim-projectionist
- **Editing**: vim-surround, vim-commentary, vim-unimpaired, splitjoin, doorboy, vim-abolish
- **Colorscheme**: Catppuccin Mocha

## Structure

```
init.lua                        # entry point: loads core then plugins
lua/jaapied/
  core/                         # settings, keymaps, commands (loaded before plugins)
  plugins/
    init.lua                    # lazy.nvim bootstrap
    config/                     # one file per plugin or plugin group
after/plugin/                   # post-plugin highlights and autocmds
```

## Thanks

Thanks to Wincent for his [pinnacle](https://github.com/wincent/pinnacle) plugin which helped get highlight tweaks working cleanly.

## Copying

This is unlicensed work so you can copy at will. I've only included work from others where that work is also unlicensed. If you think I've copied something from you and want credit, please let me know.
