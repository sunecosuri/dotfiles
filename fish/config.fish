# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

set -x GOPATH $HOME/.work/
set -x PATH $GOPATH/bin $PATH

function fzf_select_repository
    ghq list | fzf | read repo
    [ -n "$repo" ]; or return 1
    cd (ghq root)/$repo
    commandline -f repaint
end

function fzf_select_history
    history | fzf | read cmd
    commandline $cmd
    commandline -f repaint
end

function fish_user_key_bindings
    bind \cf 'fzf_select_repository'
    bind \cr 'fzf_select_history'
end

alias sudo 'sudo -E'
