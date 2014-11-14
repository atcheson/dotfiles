# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch correct share_history
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/m/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PATH=$PATH:~/.cabal/bin:~/scripts

zstyle ':completion:*' menu select

autoload -U colors && colors

PROMPT="%{$fg[blue]%}[%{$reset_color%}%1d%{$fg[blue]%}]%{$fg[blue]%}>%{$reset_color%} "
