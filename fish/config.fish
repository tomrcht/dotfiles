set -g -x LANG en_US.UTF-8
set -g -x EDITOR 'nvim'
set -g -x USER_NICKNAME 'tom'
set -g -x PAGER 'most'

set -g -x RUSTPATH $HOME/.cargo
set -g -x SRC_BIN $HOME/source/bin
# set -g -x PYTHON_PATH $HOME/Library/Python/3.7
set -g -x PATH /bin /sbin /usr/local/sbin /usr/bin /usr/sbin $RUSTPATH/bin $SRC_BIN $PATH

source /Users/tom/.config/fish/aliases
set fish_greeting ''

starship init fish | source
