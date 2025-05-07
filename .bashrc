#
# ~/.bashrc
#
export XDG_CONFIG_HOME="$HOME/.config"
alias vi='nvim'
alias vim='nvim'
alias v='nvim'
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=$PATH:/home/matteo/.local/bin
eval "$(oh-my-posh init bash --config ~/night-owl.omp.json)"
alias config='/usr/bin/git --git-dir=/home/matteo/.cfg/ --work-tree=/home/matteo'
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# pnpm
export PNPM_HOME="/home/matteo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
