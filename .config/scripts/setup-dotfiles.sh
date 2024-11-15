#!/usr/bin/env bash

echo ".dotfiles" >> .gitignore
git clone --bare git@github.com:tofu-salad/.dotfiles.git $HOME/.dotfiles
alias config='$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
