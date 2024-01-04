# nvim_config #
My (relatively) minimal neovim config with plugins installed with [lazy.nvim](https://github.com/folke/lazy.nvim) package manager
## Dependencies ##
* [Neovim](https://github.com/neovim/neovim/releases/tag/v0.9.5)
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
git clone git@github.com:slhernandes/nvim_config.git || git clone https://github.com/slhernandes/nvim_config.git
```
**Make sure to properly clone the project before continuing**
```sh
mv nvim_config nvim
nvim .
```
, and if the plugins are not loaded or not updated, type:
```vim
:Lazy sync
```
to sync the plugins.
