################################################
#               oh-my-zsh config               #
################################################

export ZSH="/home/amr/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  cargo
  colorize
  command-not-found
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
  )

source $ZSH/oh-my-zsh.sh


################################################
#               Env, PATH...etc                #
################################################
export LANG=en_US.UTF-8

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$HOME/.cargo/bin:$PATH

################################################
#                   Aliases                    #
################################################
alias cls="clear"
alias ls="ls --color=auto"
alias lsa="ls -lha --group-directories-first"
alias pacman="sudo pacman"
alias vim="nvim"
alias commit-date="date +'%d/%m/%y %I:%M %p' | git commit -F -"
#############
eval "$(starship init zsh)"
