if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x FZF_DEFAULT_OPTS '--height 50% --reverse --border'

# GO
set -x GOPATH $HOME/.work
set -x PATH $GOPATH/bin $PATH
set -x GOBIN $GOPATH/bin

# Rust
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

# starship
starship init fish | source

# direnv
# eval (direnv hook fish)

if not test (asdf which node)
  asdf plugin add nodejs;
end
source /usr/local/opt/asdf/asdf.fish

# aws-cli
complete -c aws -f -a '(begin; set -lx COMP_SHELL fish; set -lx COMP_LINE (commandline); /usr/local/bin/aws_completer; end)'

# alias
alias sudo 'sudo -E'
alias nr 'npm run'
alias ls 'exa'
alias ssh 'ssh -A'
# alias cat 'bat'
set -g segment_separator "$segment_separator\n"

## git alias
alias gco 'git checkout'
alias grh 'git reset --hard'
alias grs 'git reset --soft'
alias gp 'git pull'
alias gst 'git stash'
alias gf 'git fetch'

# func
function r
  ghq list | fzf | read repo && cd (ghq root)/$repo
end

function h
  history | fzf | read cmd
  commandline $cmd
  commandline -f repaint
end

function cb
  eval "git branch --sort=-authordate | fzf --query (commandline)" | read -z select
  if not test -z $select
    git switch $select
  end
  commandline -f repaint
end

function togif
  if count $argv = 2
    ffmpeg -i $argv[1] -fs 9M -r 5 $argv[2]
    return 1
  else
    echo 'USAGE: togif [INPUT] [OUTPUT]'
  end
end

# asdf
source /usr/local/opt/asdf/asdf.fish
