#antigen config
source ~/.antigen/antigen.zsh
antigen use oh-my-zsh

antigen bundle history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

#the rest
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch correct share_history
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/m/.zshrc'

autoload -Uz compinit
compinit

export PATH=$PATH:~/.cabal/bin:~/scripts

zstyle ':completion:*' menu select

autoload -U colors && colors

PROMPT="%{$fg[blue]%}[%{$reset_color%}%1d%{$fg[blue]%}]%{$fg[blue]%}>%{$reset_color%} "
