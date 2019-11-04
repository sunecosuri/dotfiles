set -x FZF_DEFAULT_OPTS '--height 50% --reverse --border'

# GO
set -x GOPATH $HOME/.work
set -x PATH $GOPATH/bin $PATH
set -x GOBIN $GOPATH/bin

# starship
eval (starship init fish)

# direnv
eval (direnv hook fish)

# anyenv
status --is-interactive; and source (anyenv init -|psub)
set -x PATH $HOME/.anyenv/bin $PATH

# aws-cli
complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); /usr/local/bin/aws_completer; end)'

# alias
alias sudo 'sudo -E'
alias nr 'npm run'
alias ls 'exa'
alias ssh 'ssh -A'
alias cat 'bat'
set -g segment_separator "$segment_separator\n"

# func
function r
  ghq list | fzf | read repo && cd (ghq root)/$repo
end

function h
    history | fzf | read cmd
    commandline $cmd
    commandline -f repaint
end

