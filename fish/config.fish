set -g -x LANG en_US.UTF-8
set -g -x EDITOR 'nvim'
set -g -x USER_NICKNAME 'tom'
set -g -x PAGER 'most'
# set -g -x LC_ALL 'en_US.UTF-8'

set -g -x RUSTPATH $HOME/.cargo
set -g -x EPITECH_PATH $HOME/source/courses/epitech
set -g -x PYTHON_PATH $HOME/Library/Python/3.7
set -g -x PATH /bin /sbin /usr/local/sbin /usr/bin /usr/sbin $GOPATH/bin $RUSTPATH/bin $PYTHON_PATH/bin $PATH

source /Users/tom/.config/fish/aliases
set fish_greeting ''

thefuck --alias | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tom/source/gcloud/path.fish.inc' ]; . '/Users/tom/source/gcloud/path.fish.inc'; end

starship init fish | source
