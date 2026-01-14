## Installation

```bash
git clone --bare https://github.com/gtsitsik/my-vim-settings.git "$HOME/.dotfiles"
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
source $HOME/.dotfiles/install.sh
