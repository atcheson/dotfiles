set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'scrooloose/syntastic'
Plugin 'FSwitch'
Plugin 'ProtoDef'

filetype plugin indent on

set number
syntax on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set hlsearch
set incsearch

silent !chmod +x ~/.vim/bundle/ProtoDef/pullproto.pl

let g:syntastic_cpp_check_header = 1
let protodefprotogetter = "~/.vim/bundle/ProtoDef/pullproto.pl"
