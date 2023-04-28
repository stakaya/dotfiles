#!/bin/zsh
ln -s $HOME/dotfiles/zshrc $HOME/.zshrc

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
source ~/.zshrc
zinit self-update

chsh -s $(which zsh)
