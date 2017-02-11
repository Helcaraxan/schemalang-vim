# schemalang-vim
## Purpose
Syntaxic coloring support in the VIm editor for Schemalang.
Schemalang is used by Improbable's [SpatialOS](https://spatialos.improbable.io) platform.

## Support
This repo is maintained on a volontary basis. Feel free to PR or create issues but there are no guarantees on the
time-to-fix or time-to-feature.

## Install on Linux / macOS
**NOTE** This repository is compatible for use with the [Pathogen](https://github.com/tpope/vim-pathogen) VIm plugin
manager.

To enable schemalang support in VIm do the following in a (Bash) terminal:
* If you don't use Pathogen
```bash
# Clone the repository (you can choose where to clone it).
git clone https://github.com/Helcaraxan/schemalang-vim

# Go into the local clone.
cd schemalang-vim

# Copy the required content to your ~/.vim folder.
VIM_HOME="$HOME/.vim"
if [ ! -e "$VIM_HOME" ]; then
  mkdir -p "$VIM_HOME"
fi
cp -r ftdetect ftplugin syntax "$VIM_HOME"
```
* If you do use Pathogen
```bash
# Go to the Pathogen repository folder.
cd "$HOME/.vim/bundle"

# Clone the repository.
git clone https://github.com/Helcaraxan/schemalang-vim
```