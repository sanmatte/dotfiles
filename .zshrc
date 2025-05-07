export PATH="$PATH:/opt/homebrew/bin/"
export PATH="/opt/homebrew/bin:$PATH"
# export PATH=~/miniconda3/bin:$PATH
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export XDG_CONFIG_HOME="$HOME/.config"
alias diomerda="rm -rf $HOME/.docker/config.json | echo 'Dio has successfully deleted ~/.docker/config.json'"
alias docker="rm -rf $HOME/.docker/config.json | docker"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/matteo/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else


#   Disable auto activation of base environment for conda
    if [ -f "/Users/matteo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/matteo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/matteo/miniconda3/bin:$PATH"
    fi

#fi
#unset __conda_setup
# <<< conda initialize <<<

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
	eval "$(oh-my-posh init zsh --config ~/.config/ompthemes/night-owl.omp.json)"
fi
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
alias config='/usr/bin/git --git-dir=/Users/matteo/.cfg/ --work-tree=/Users/matteo'
export XDG_CONFIG_HOME="$HOME/.config"
