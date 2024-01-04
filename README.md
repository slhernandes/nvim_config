# nvim_config #
## Dependencies ##
* [Neovim](https://github.com/neovim/neovim/releases/tag/v0.9.5)
## Installation ##
### 1. Delete or move existing nvim config ###
Do
```sh
cd ~/.config
rm -rf nvim

```
to delete the nvim config, or
```sh
cd ~/.config
mv nvim .nvim.bak
```
to move the nvim config.
### 2. Clone the nvim config and sync the plugins ###
```sh
git clone git@github.com:slhernandes/nvim_config.git
```
**Make sure to properly clone the project before continuing**
```sh
mv nvim_config nvim
nvim .
```
```vim
:Lazy sync
```
