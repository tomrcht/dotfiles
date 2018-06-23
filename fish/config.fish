set -g -x EDITOR "nvim"
set -g -x USER_NICKNAME "Hoodie"
set -g -x PAGER "most"
set -g -x GOPATH $HOME/development/go
set -g -x FLUTTERPATH $HOME/development/flutter
set -g -x EPITECH_PATH $HOME/development/epitech
set -g -x PATH /bin /sbin /usr/bin /usr/sbin /usr/local/go/bin $HOME/.cargo/bin $GOPATH/bin $PATH

source /Users/hoodie/.config/fish/aliases
set fish_greeting ""

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hoodie/Documents/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/hoodie/Documents/google-cloud-sdk/path.fish.inc'; else; . '/Users/hoodie/Documents/google-cloud-sdk/path.fish.inc'; end; end
