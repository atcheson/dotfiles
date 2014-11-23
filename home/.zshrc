#do this first to prevent flickering
export PATH=$PATH:$HOME/.homesick/repos/dotfiles/scripts:$HOME/.local/bin:~/.cabal/bin:~/scripts:$HOME/.dynamic-colors/bin:$HOME/git/depot_tools

for infile in $HOME/.colorschemes/*
do
    outfile=$HOME/.dynamic-colors/colorschemes/`basename $infile`
    if [ ! -f $outfile ]; then
        ln -s $infile $outfile
    fi
done
dynamic-colors init

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

zstyle ':completion:*' menu select

autoload -U colors && colors

source $HOME/.dynamic-colors/completions/dynamic-colors.zsh

PROMPT="%{$fg[blue]%}[%{$reset_color%}%1d%{$fg[blue]%}]%{$fg[blue]%}>%{$reset_color%} "
