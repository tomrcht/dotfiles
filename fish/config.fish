set -g -x EDITOR 'nvim'
set -g -x USER_NICKNAME 'tom'
set -g -x PAGER 'most'

set -g -x GOPATH $HOME/development/go
set -g -x EPITECH_PATH $HOME/development/epitech
set -g -x PATH /bin /sbin /usr/local/sbin /usr/bin /usr/sbin $GOPATH/bin $PATH

source /Users/tom/.config/fish/aliases
set fish_greeting ''

thefuck --alias | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tom/stuff/google-cloud-sdk/path.fish.inc' ]; . '/Users/tom/stuff/google-cloud-sdk/path.fish.inc'; end
