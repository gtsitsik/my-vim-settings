#!/usr/bin/env bash
git clone --bare https://github.com/gtsitsik/my-vim-settings.git "$HOME/.dotfiles"
a='gitc(){ git --git-dir=\$HOME/.dotfiles --work-tree=\$HOME "$@" ; }'
grep -Fq -- "$a" ~/.bashrc || echo "$a" >> ~/.bashrc
eval "$a"
gitc checkout
gitc config --local status.showUntrackedFiles no
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -es -u ~/.vimrc -i NONE +"PlugInstall --sync"  +qa
vim +"set ft=python" +"LspInstallServer! ruff"
vim +"set ft=python" +"LspInstallServer! basedpyright-langserver"
reset
