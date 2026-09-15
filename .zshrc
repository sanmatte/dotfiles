# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=5000
autoload -Uz compinit
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select

bindkey -e
bindkey -v
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

function zle-keymap-select {
    case $KEYMAP in
        vicmd) printf '\e[1 q' ;;  # block cursor
        *)     printf '\e[5 q' ;;  # beam cursor
    esac
}

function zle-line-init {
    zle-keymap-select
}

function zle-line-finish {
    printf '\e[5 q'
}

zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish


# Obsidian
alias obsi="/var/home/matteo/.local/bin/obsidian-squashfs-root/AppRun"

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/var/home/matteo/.zshrc'

export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
export XDG_CONFIG_HOME="$HOME/.config"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# (not really) a workaround for podman compose eating terminal stdin buffer input
alias d="podman compose down"

# ls -a shortcut
alias la='ls -a'

# Check if inside devcontainer or not and set different theme
if [[ -n "$CONTAINER_ID" ]]; then
	eval "$(~/.local/bin/oh-my-posh init zsh --config ~/.config/ompthemes/mojada.omp.json)"
	alias vim="nvim"
	alias v="nvim"
else
	eval "$(~/.local/bin/oh-my-posh init zsh --config ~/.config/ompthemes/night-owl.omp.json)"
	alias nvim="~/.local/bin/nvim-linux-x86_64.appimage"
	alias vim="~/.local/bin/nvim-linux-x86_64.appimage"
	alias v="~/.local/bin/nvim-linux-x86_64.appimage"
fi

alias config='/usr/bin/git --git-dir=/var/home/matteo/.cfg/ --work-tree=/var/home/matteo'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$HOME/.local/bin:$PATH"
