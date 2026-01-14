#!/usr/bin/env bash
a='alias gitc="git --git-dir=\$HOME/.dotfiles --work-tree=\$HOME"'
grep -Fq -- "$a" ~/.bashrc || { echo $a >> ~/.bashrc; source ~/.bashrc; }
gitc config --local status.showUntrackedFiles no
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u ~/.vimrc -i NONE +"PlugInstall --sync"  +qa
vim +"set ft=python" +"LspInstallServer ruff"
vim +"set ft=python" +"LspInstallServer basedpyright-langserver"
