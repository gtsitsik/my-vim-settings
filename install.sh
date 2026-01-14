#!/usr/bin/env bash

git init --bare $HOME/.dotfiles
a='alias gitc="git --git-dir=\$HOME/.dotfiles --work-tree=\$HOME"'
grep -Fq -- "$a" ~/.bashrc || { echo $a >> ~/.bashrc; source ~/.bashrc; }
gitc config --local status.showUntrackedFiles no
gitc branch -M main
gitc remote add origin https://github.com/gtsitsik/my-vim-settings.git
gitc fetch
gitc reset --hard origin/main
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u ~/.vimrc -i NONE +"PlugInstall --sync" +qa""
