# nvim_config #
My (relatively) minimal neovim config with plugins installed with [lazy.nvim](https://github.com/folke/lazy.nvim) package manager
## Dependencies ##
* [Cargo](https://github.com/rust-lang/cargo)
* [Neovim](https://github.com/neovim/neovim/releases/tag/v0.9.5)
* [Ripgrep](https://github.com/BurntSushi/ripgrep)
* [fd](https://github.com/sharkdp/fd)
* [Nerdfont](https://github.com/ryanoasis/nerd-fonts)
* [Nonicons](https://github.com/ya2s/nonicons/blob/main/dist/nonicons.ttf)
* [Yazi](https://github.com/sxyazi/yazi)
* Any terminal emulator with image protocol support (e.g. [Kitty](https://github.com/kovidgoyal/kitty))
## Installation ##
### 1. Delete or move existing nvim config ###
Do
```sh
rm -rf ~/.config/nvim ~/.local/share/nvim
cd ~/.config
```
to delete the existing nvim config, or
```sh
cd ~/.config
mv nvim .nvim.bak
rm -rf ~/.local/share/nvim
```
to move the nvim config.
### 2. Clone the nvim config and sync the plugins ###
```sh
git clone https://github.com/slhernandes/nvim_config.git $HOME/.config/nvim
```
**Make sure to properly clone the project before continuing**
```sh
nvim .
```
To update the plugins type
```vim
:=vim.pack.update()
```
, and then type `:w` after reviewing the update log to write the update to the disk.
## Treesitter ##
Since [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) is no longer maintained,
we need to install each tree-sitter parser manually.
To do that, first, create `~/.local/share/nvim/site/parser/` and `~/.local/share/nvim/site/queries/`.
Then, put the parser (`<lang>.so`) in `parser/` and the queries `<lang>/*.scm` in `queries/`.
For example, to use cpp-tree-sitter, the file tree should look like this
```
~/.local/share/nvim/site/
├── parser/
│   └── cpp.so
└── queries/
    └── cpp/
        ├── folds.scm
        ├── highlights.scm
        ├── indents.scm
        ├── injections.scm
        └── locals.scm
```
